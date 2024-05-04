resource "aws_instance" "gpu_instance" {
  count = var.enabled ? 1 : 0

  # Deep Learning Base OSS Nvidia Driver GPU AMI (Ubuntu 22.04) 20240501
  # https://aws.amazon.com/jp/releasenotes/aws-deep-learning-base-gpu-ami-ubuntu-22-04/
  ami                  = "ami-07752588c69983b3c"
  instance_type        = "g5.xlarge"
  subnet_id            = var.subnet_id
  security_groups      = [aws_security_group.gpu_instance.id]
  iam_instance_profile = aws_iam_instance_profile.profile_gpu_instance.name

  user_data = <<EOF
  #!/bin/bash
  sudo apt-get update
  sudo apt -y install wget git tmux

  # stable-diffusion-webui
  sudo -u ubuntu git clone https://github.com/AUTOMATIC1111/stable-diffusion-webui.git -b 1.9.3
  EOF

  tags = {
    Name = "gpu-instance"
  }
}
