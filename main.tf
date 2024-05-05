module "vpc" {
  source = "./modules/vpc"
}

module "s3_stable_diffusion" {
  source = "./modules/s3-private-bucket"

  bucket_name = "yyd-stable-diffusion"
}

# terraform [plan|apply|destroy] -target=module.ec2
#
# module "ec2" {
#   source = "./modules/ec2"

#   vpc_id    = module.vpc.vpc_id
#   subnet_id = module.vpc.public_subnet_id
# }

# terraform [plan|apply|destroy] -target=module.gpu-instance
#
# module "gpu-instance" {
#   source = "./modules/gpu-instance"

#   subnet_id = module.vpc.public_subnet_id
#   vpc_id    = module.vpc.vpc_id

#   iam_policy_arns = [
#     module.s3_stable_diffusion.read_write_policy_arn
#   ]
# }
