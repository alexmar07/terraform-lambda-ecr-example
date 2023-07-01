output "lambda" {
  value = aws_lambda_function.code-lambda.function_name
}

output "apigateway" {
  value = aws_apigatewayv2_api.main.api_endpoint
}

