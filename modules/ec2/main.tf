

resource "aws_instance" "private_instance" {
  # Amazon Linux 2 AMI (HVM) - Kernel 5.10, SSD Volume Type
  ami                  = "ami-04e0b6d6cfa432943"
  instance_type        = "t2.micro"
  subnet_id            = var.subnet_id
  security_groups      = [aws_security_group.ec2.id]
  iam_instance_profile = aws_iam_instance_profile.profile_private_instance.name

  tags = {
    Name = "private-instance"
  }
}
