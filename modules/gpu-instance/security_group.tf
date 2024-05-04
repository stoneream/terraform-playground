resource "aws_security_group" "gpu_instance" {
  name   = "gpu-instance-sg"
  vpc_id = var.vpc_id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "gpu-instance-sg"
  }
}
