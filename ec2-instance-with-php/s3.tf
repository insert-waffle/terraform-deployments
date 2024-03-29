# Creating S3 bucket & uploading files
resource "aws_s3_bucket" "b1" {

  bucket = var.BUCKET_NAME
  acl    = "private" # or can be "private"
  tags = {
    Name = var.BUCKET_TAG_NAME
  }

}

resource "aws_s3_bucket_object" "b1" {

  for_each = fileset("upload/", "*")
  bucket   = aws_s3_bucket.b1.id
  key      = each.value
  acl      = "public-read"
  source   = "upload/${each.value}"
  etag     = filemd5("upload/${each.value}")

}