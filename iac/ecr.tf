resource "aws_ecr_repository" "code" {
  name                 = "code"
  image_tag_mutability = "MUTABLE"
  force_delete         = true
  image_scanning_configuration {
    scan_on_push = true
  }
}

resource "null_resource" "upload-image" {

  provisioner "local-exec" {
    command = "cd .. && task build"
  }

  depends_on = [aws_ecr_repository.code]
}