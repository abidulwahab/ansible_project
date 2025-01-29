
# 
terraform {
  backend "s3" {
    bucket         = "abibucket225"
    key            = "key/terraform.tfstate"
    region         = "eu-west-2"
#    dynamodb_table = "terraform-lock"
  }
}
