import json


def lambda_handler(event, context):
    print("Phase 3 Lambda invoked")
    print(json.dumps({
        "raw_path": event.get("rawPath"),
        "request_context": event.get("requestContext", {}),
    }))

    body = {
        "message": "Hello from Phase 3 Lambda",
        "phase": "phase-3",
        "path": event.get("rawPath", "/hello"),
        "request_id": getattr(context, "aws_request_id", None),
    }

    return {
        "statusCode": 200,
        "headers": {
            "Content-Type": "application/json"
        },
        "body": json.dumps(body),
    }
