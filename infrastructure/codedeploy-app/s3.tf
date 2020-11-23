resource "aws_s3_bucket" "deploy-bucket" {
  bucket = "${var.app-name}-deployment"
}