provider "aws" {
  region = "ap-northeast-1"
}

# resource "aws_instance" "example" {
#   # Amazon Linux 2 AMI (HVM) - Kernel 5.10, SSD Volume Type
#   ami           = "ami-04e0b6d6cfa432943"
#   instance_type = "t2.micro"
# }

module "vpc" {
  source = "./modules/vpc"
}
