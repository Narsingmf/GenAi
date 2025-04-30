provider "aws" {
  region = "us-east-1"
}

module "vpc_test" {
  source = "../modules/vpc"

  vpc_cidr_block     = "10.0.0.0/16"
  public_subnet_cidr = "10.0.1.0/24"
  private_subnet_cidr = "10.0.2.0/24"
  availability_zone  = "us-east-1a"
  project_name       = "test-vpc"
}

output "vpc_id" {
  value = module.vpc_test.vpc_id
}

output "private_subnet_id" {
  value = module.vpc_test.private_subnet_id
}

output "public_subnet_id" {
  value = module.vpc_test.public_subnet_id
}