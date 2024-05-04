# read-only

resource "aws_iam_policy" "s3_read_only_access" {
  name   = "s3-${var.bucket_name}-read-only"
  policy = data.aws_iam_policy_document.s3_read_only_access.json
}

data "aws_iam_policy_document" "s3_read_only_access" {
  statement {
    actions = [
      "s3:GetObject",
      "s3:ListBucket"
    ]
    resources = [
      "arn:aws:s3:::${var.bucket_name}",
      "arn:aws:s3:::${var.bucket_name}/*"
    ]
  }
}

# read-write

resource "aws_iam_policy" "s3_read_write_access" {
  name   = "s3-${var.bucket_name}-read-write"
  policy = data.aws_iam_policy_document.s3_access.json
}

data "aws_iam_policy_document" "s3_access" {
  statement {
    actions = [
      "s3:GetObject",
      "s3:PutObject",
      "s3:ListBucket"
    ]
    resources = [
      "arn:aws:s3:::${var.bucket_name}",
      "arn:aws:s3:::${var.bucket_name}/*"
    ]
  }
}
