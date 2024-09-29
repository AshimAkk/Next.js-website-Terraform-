terraform {
  backend "s3" {
    bucket = "next.js-website-statefile-99"
    key = "global/s3/terraform.tfstate"
    dynamodb_table = "terraform-lock-file"
    region = "ap-southeast-2"
  }
}