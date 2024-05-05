resource "aws_instance" "gpu_instance" {
  count = var.instance_enabled ? 1 : 0

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
  sudo add-apt-repository ppa:deadsnakes/ppa -y
  sudo apt-get -y install wget git tmux
  sudo apt-get -y install python3 python-is-python3 python3-pip python3-venv
  sudo apt-get -y install python3.10 python3.10-distutils python3.10-venv python3.10-tk
  curl -sS https://bootstrap.pypa.io/get-pip.py | python3.10
  python3.10 -m pip install --upgrade pip
  sudo update-alternatives --install /usr/bin/python3 python3 /usr/bin/python3.10 1

  # stable-diffusion-webui
  cd /home/ubuntu
  sudo -u ubuntu git clone https://github.com/AUTOMATIC1111/stable-diffusion-webui.git
  sudo -u ubuntu nohup bash -c 'bash <(wget -qO- https://raw.githubusercontent.com/AUTOMATIC1111/stable-diffusion-webui/master/webui.sh) &> sd-webui-log.txt' &

  # file-browser
  cd /home/ubuntu
  sudo -u ubuntu curl -fsSL https://raw.githubusercontent.com/filebrowser/get/master/get.sh | bash
  sudo -u ubuntu nohup bash -c 'filebrowser -r /home/ubuntu &> ./browser-log.txt' &

  EOF

  tags = {
    Name = "gpu-instance"
  }
}
