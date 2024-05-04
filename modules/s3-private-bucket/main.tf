resource "aws_s3_bucket" "private_bucket" {
  bucket = var.bucket_name

  tags = {
    Name = var.bucket_name
  }
}

# バージョニングを無効化
resource "aws_s3_bucket_versioning" "private_bucket" {
  bucket = aws_s3_bucket.private_bucket.id

  versioning_configuration {
    status = "Disabled"
  }
}

# パブリックアクセスをブロックする
resource "aws_s3_bucket_public_access_block" "private_bucket" {
  bucket = aws_s3_bucket.private_bucket.id

  block_public_acls       = true # バケットとオブジェクトのパブリックACLを拒否する
  block_public_policy     = true # バケットポリシーによるパブリックアクセスを拒否する
  ignore_public_acls      = true # バケットとオブジェクトのパブリックACLを無視する
  restrict_public_buckets = true # バケットへのパブリックアクセスを制限する
}
