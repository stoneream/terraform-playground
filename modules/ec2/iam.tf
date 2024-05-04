resource "aws_iam_role" "ec2" {
  name               = "ec2"
  assume_role_policy = data.aws_iam_policy_document.assume_role.json
}

# SSM

data "aws_iam_policy_document" "assume_role" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }
  }
}

data "aws_iam_policy" "policy_ssm_managed_instance_core" {
  # https://docs.aws.amazon.com/ja_jp/aws-managed-policy/latest/reference/AmazonSSMManagedInstanceCore.html
  arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
}

resource "aws_iam_role_policy_attachment" "ssm_managed_instance_core" {
  policy_arn = data.aws_iam_policy.policy_ssm_managed_instance_core.arn
  role       = aws_iam_role.ec2.name
}

resource "aws_iam_instance_profile" "profile_private_instance" {
  name = "profile_private_instance"
  role = aws_iam_role.ec2.name
}
