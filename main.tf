provider "aws" {
  region = var.region
}

module "vpc" {
  source = "./modules/vpc"

  vpc_cidr_block    = var.vpc_cidr_block
  public_subnet_cidr = var.public_subnet_cidr
  private_subnet_cidr = var.private_subnet_cidr
  availability_zone = var.availability_zone
  project_name      = var.project_name
}

module "ec2" {
  source = "./modules/ec2"

  project_name      = var.project_name
  private_subnet_id = module.vpc.private_subnet_id
  vpc_id            = module.vpc.vpc_id
  instance_type     = var.instance_type
  ami_id            = var.ami_id
  key_name          = var.key_name
}