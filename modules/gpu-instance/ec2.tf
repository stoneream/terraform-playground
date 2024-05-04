resource "aws_instance" "gpu_instance" {
  count = var.enabled ? 1 : 0

  # Deep Learning Base OSS Nvidia Driver GPU AMI (Ubuntu 22.04) 20240501
  # https://aws.amazon.com/jp/releasenotes/aws-deep-learning-base-gpu-ami-ubuntu-22-04/
  ami                  = "ami-07752588c69983b3c"
  instance_type        = "g5.xlarge"
  subnet_id            = var.subnet_id
  security_groups      = [aws_security_group.gpu_instance.id]
  iam_instance_profile = aws_iam_instance_profile.profile_gpu_instance.name

  root_block_device {
    volume_type           = "gp3"
    volume_size           = 20
    delete_on_termination = true
  }

  ebs_block_device {
    device_name = "/dev/sdf"
    volume_id   = aws_ebs_volume.stable-diffusion.id
  }

  user_data = <<EOF
  #!/bin/bash
  sudo apt-get update
  sudo add-apt-repository ppa:deadsnakes/ppa -y
  sudo apt-get -y install wget git tmux
  sudo apt-get -y install python3 python-is-python3 python3-pip python3-venv
  sudo apt-get -y install python3.10 python3.10-distutils python3.10-venv python3.10-tk
  curl -sS https://bootstrap.pypa.io/get-pip.py | python3.10
  python3.10 -m pip install --upgrade pip
  sudo update-alternatives --install /usr/bin/python3 python3 /usr/bin/python3.10 1

  # stable-diffusion-webui
  if [ ! -e /dev/sdf/stable-diffusion-webui ]; then
    cd /dev/sdf
    sudo -u ubuntu git clone https://github.com/AUTOMATIC1111/stable-diffusion-webui.git
    sudo -u ubuntu nohup bash -c 'bash <(wget -qO- https://raw.githubusercontent.com/AUTOMATIC1111/stable-diffusion-webui/master/webui.sh) &> sd-webui-log.txt' &
  fi

  # file-browser
  if [ ! -e /dev/sdf/file-browser ]; then
    cd /dev/sdf
    sudo -u ubuntu curl -fsSL https://raw.githubusercontent.com/filebrowser/get/master/get.sh | bash
    sudo -u ubuntu nohup bash -c 'filebrowser -r /home/ubuntu &> ./browser-log.txt' &
  fi

  EOF

  tags = {
    Name = "gpu-instance"
  }
}

# EBS
resource "aws_ebs_volume" "workspace" {
  availability_zone = "ap-northeast-1"
  type              = "gp3"
  size              = 50
  encrypted         = true


  tags = {
    Name = "stable-diffusion-workspace"
  }
}
