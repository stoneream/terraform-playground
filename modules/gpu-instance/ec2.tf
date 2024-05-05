resource "aws_instance" "gpu_instance" {
  # Deep Learning Base OSS Nvidia Driver GPU AMI (Ubuntu 22.04) 20240501
  # https://aws.amazon.com/jp/releasenotes/aws-deep-learning-base-gpu-ami-ubuntu-22-04/
  ami                  = "ami-07752588c69983b3c"
  instance_type        = "g5.xlarge"
  subnet_id            = var.subnet_id
  security_groups      = [aws_security_group.gpu_instance.id]
  iam_instance_profile = aws_iam_instance_profile.profile_gpu_instance.name

  user_data = file("${path.module}/script.sh")

  root_block_device {
    volume_size           = 120
    volume_type           = "gp3"
    delete_on_termination = true
  }

  tags = {
    Name = "gpu-instance"
  }
}
