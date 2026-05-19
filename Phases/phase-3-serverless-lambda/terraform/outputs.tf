output "lambda_function_name" {
  description = "Name of the Phase 3 Lambda function."
  value       = aws_lambda_function.hello.function_name
}

output "lambda_execution_role_arn" {
  description = "ARN of the Lambda execution role."
  value       = aws_iam_role.lambda_execution_role.arn
}

output "lambda_log_group_name" {
  description = "CloudWatch log group used by the Lambda function."
  value       = aws_cloudwatch_log_group.lambda.name
}

output "http_api_endpoint" {
  description = "Base invoke URL for the HTTP API stage."
  value       = aws_apigatewayv2_stage.dev.invoke_url
}

output "hello_route_url" {
  description = "Full URL for the GET /hello route."
  value       = "${aws_apigatewayv2_stage.dev.invoke_url}/hello"
}

output "http_api_id" {
  description = "ID of the HTTP API."
  value       = aws_apigatewayv2_api.http_api.id
}
