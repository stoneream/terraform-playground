

resource "aws_instance" "private_instance" {
  # Amazon Linux 2 AMI (HVM) - Kernel 5.10, SSD Volume Type
  ami             = "ami-04e0b6d6cfa432943"
  instance_type   = "t2.micro"
  subnet_id       = var.subnet_id
  security_groups = [aws_security_group.ec2.id]

  tags = {
    Name = "private-instance"
  }
}
