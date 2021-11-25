resource "aws_s3_bucket" "charts_bucket" {
  bucket = var.chart_name
  acl    = "private"

  tags = {
    Name        = var.chart_name
  }
}


