terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
#Added comment in backend.tf
  backend "s3" {
    bucket = "mt25009-statefile" # <-- your existing S3 bucket
    key    = "ec2/terraform.tfstate"           # path inside bucket
    region = "ap-southeast-2"                       # change to your bucket's region
  }
}