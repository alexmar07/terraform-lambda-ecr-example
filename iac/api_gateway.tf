resource "aws_apigatewayv2_api" "main" {
  name          = "main"
  protocol_type = "HTTP"

  cors_configuration {
    allow_methods = ["*"]
    allow_headers = ["*"]
    allow_origins = ["*"]
  }
}

resource "aws_apigatewayv2_integration" "code-lambda" {
  api_id = aws_apigatewayv2_api.main.id

  integration_type = "AWS_PROXY"
  integration_uri  = aws_lambda_function.code-lambda.invoke_arn
}

resource "aws_apigatewayv2_route" "code-get-api" {
  api_id    = aws_apigatewayv2_api.main.id
  route_key = "GET /"

  target = "integrations/${aws_apigatewayv2_integration.code-lambda.id}"
}

resource "aws_apigatewayv2_stage" "default" {
  api_id = aws_apigatewayv2_api.main.id

  name        = "$default"
  auto_deploy = true

  access_log_settings {
    destination_arn = aws_cloudwatch_log_group.main_api_gw.arn

    format = jsonencode({
      requestId               = "$context.requestId"
      sourceIp                = "$context.identity.sourceIp"
      requestTime             = "$context.requestTime"
      protocol                = "$context.protocol"
      httpMethod              = "$context.httpMethod"
      resourcePath            = "$context.resourcePath"
      routeKey                = "$context.routeKey"
      status                  = "$context.status"
      responseLength          = "$context.responseLength"
      integrationErrorMessage = "$context.integrationErrorMessage"
      }
    )
  }
}

resource "aws_cloudwatch_log_group" "main_api_gw" {
  name = "/aws/api-gw/${aws_apigatewayv2_api.main.name}"

  retention_in_days = 30
}