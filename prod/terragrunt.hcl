remote_state{
  backend = "s3"
  generate ={
    path = "backend.tf"
    if_exists = "overwrite"
  }
  config = {
    bucket = "bibek-prod-terraform-state-bucket"
    key = "${path_relative_to_include()}/terraform.tfstate"
    region = "us-east-1"
    encrypt = true
    dynamodb_table = "bibek-terraform-lock-table-prod"
  }
}

generate "provider"{
  path = "provider.tf"
  if_exists = "overwrite"
  contents = <<EOF
  terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.43.0"
    }
  }
}


provider "aws" {
  region                   = "us-east-1"
  shared_credentials_files = ["C:/Users/Dell/.aws/credentials"]
  shared_config_files      = ["~/.aws.config"]

  default_tags {
    tags = {
      Creator   = "bkarna65@gmail.com"
      Project   = "Intern"
      Deletable = "Yes"
    }
  }

}
EOF
}

