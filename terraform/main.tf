terraform {
  required_version = ">= 0.12"
}

provider "aws" {
  shared_credentials_file = "$HOME/.aws/credentials"
  profile                 = "default"
  region                  = var.aws_region
}

module "network" {
  source = "./modules/network"
}

module "drover_app" {
  source              = "./modules/drover_app"
  vpc_id              = module.network.vpc_id
  private_subnets_ids = module.network.private_subnets_ids
  public_subnets_ids  = module.network.public_subnets_ids
  aws_region          = var.aws_region
  #app_name = "Drover Application"
}
