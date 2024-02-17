provider "aws" {
  region = "us-east-1"
}

# module "my_vpc" {
#   source     = "./modules/aws-vpc"
#   cidr_block = "10.0.0.0/16"
# }

module "my_ec2" {
  source     = "./modules/aws-ec2"
}