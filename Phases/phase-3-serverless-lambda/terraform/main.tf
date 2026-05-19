data "archive_file" "lambda_package" {
  type        = "zip"
  source_dir  = "${path.module}/lambda_src"
  output_path = "/tmp/cloud-foundations-phase3-lambda.zip"
}

locals {
  lambda_log_group_name = "/aws/lambda/${var.lambda_function_name}"
}

resource "aws_iam_role" "lambda_execution_role" {
  name = "${var.resource_prefix}-lambda-execution-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Service = "lambda.amazonaws.com"
        }
        Action = "sts:AssumeRole"
      }
    ]
  })

  tags = var.common_tags
}

data "aws_iam_policy_document" "lambda_logs" {
  statement {
    sid       = "AllowLogGroupCreation"
    effect    = "Allow"
    actions   = ["logs:CreateLogGroup"]
    resources = ["*"]
  }

  statement {
    sid    = "AllowLogStreamWrites"
    effect = "Allow"
    actions = [
      "logs:CreateLogStream",
      "logs:PutLogEvents"
    ]
    resources = [
      "${aws_cloudwatch_log_group.lambda.arn}:*"
    ]
  }
}

resource "aws_iam_role_policy" "lambda_logs" {
  name   = "${var.resource_prefix}-lambda-logs"
  role   = aws_iam_role.lambda_execution_role.id
  policy = data.aws_iam_policy_document.lambda_logs.json
}

resource "aws_cloudwatch_log_group" "lambda" {
  name              = local.lambda_log_group_name
  retention_in_days = var.log_retention_days
  tags              = var.common_tags
}

resource "aws_lambda_function" "hello" {
  function_name    = var.lambda_function_name
  description      = "Phase 3 Lambda hello-world function."
  role             = aws_iam_role.lambda_execution_role.arn
  handler          = "app.lambda_handler"
  runtime          = "python3.12"
  filename         = data.archive_file.lambda_package.output_path
  source_code_hash = data.archive_file.lambda_package.output_base64sha256
  timeout          = var.lambda_timeout
  memory_size      = var.lambda_memory_size

  environment {
    variables = {
      SERVICE_NAME = var.lambda_function_name
      PHASE        = "phase-3"
    }
  }

  tags = var.common_tags

  depends_on = [
    aws_iam_role_policy.lambda_logs,
    aws_cloudwatch_log_group.lambda
  ]
}

resource "aws_apigatewayv2_api" "http_api" {
  name          = var.api_name
  protocol_type = "HTTP"
  tags          = var.common_tags
}

resource "aws_apigatewayv2_integration" "lambda" {
  api_id                 = aws_apigatewayv2_api.http_api.id
  integration_type       = "AWS_PROXY"
  integration_uri        = aws_lambda_function.hello.invoke_arn
  payload_format_version = "2.0"
}

resource "aws_apigatewayv2_route" "hello" {
  api_id    = aws_apigatewayv2_api.http_api.id
  route_key = "GET /hello"
  target    = "integrations/${aws_apigatewayv2_integration.lambda.id}"
}

resource "aws_apigatewayv2_stage" "dev" {
  api_id      = aws_apigatewayv2_api.http_api.id
  name        = var.api_stage_name
  auto_deploy = true
  tags        = var.common_tags
}

resource "aws_lambda_permission" "allow_apigateway" {
  statement_id  = "AllowAPIGatewayInvoke"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.hello.function_name
  principal     = "apigateway.amazonaws.com"
  source_arn    = "${aws_apigatewayv2_api.http_api.execution_arn}/*/*"
}
