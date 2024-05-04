resource "aws_iam_role" "ec2_gpu_instance" {
  name               = "ec2-gpu-instance"
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
  arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
}

resource "aws_iam_role_policy_attachment" "ssm_managed_instance_core" {
  policy_arn = data.aws_iam_policy.policy_ssm_managed_instance_core.arn
  role       = aws_iam_role.ec2_gpu_instance.name
}

# その他ロールのアタッチ

resource "aws_iam_role_policy_attachment" "attach_policy_gpu_instance" {
  for_each = var.iam_policy_arns

  role       = aws_iam_role.ec2_gpu_instance.name
  policy_arn = each.key
}

resource "aws_iam_instance_profile" "profile_gpu_instance" {
  name = "profile-gpu-instance"
  role = aws_iam_role.ec2_gpu_instance.name
}
