resource "aws_lambda_function" "code-lambda" {
  function_name = "code-lambda"
  package_type  = "Image"
  image_uri     = "${aws_ecr_repository.code.repository_url}:latest"
  role          = aws_iam_role.code-lambda.arn

  environment {
    variables = {
      foo = "bar"
    }
  }
}

resource "aws_lambda_permission" "code-api-gw" {
  statement_id  = "AllowExecutionFromAPIGateway"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.code-lambda.function_name
  principal     = "apigateway.amazonaws.com"

  source_arn = "${aws_apigatewayv2_api.main.execution_arn}/*/*"
}