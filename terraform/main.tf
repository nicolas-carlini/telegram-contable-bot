module "networking" {
  source = "./networking"
  region = var.region
} 

module "lambda" {
  source = "./lambda"
} 
