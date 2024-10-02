terraform {
  backend "s3" {
    bucket         = "next.js-state-99"
    key            = "global/s3/terraform.tfstate"
    dynamodb_table = "nextjs-db-table"
    region         = "ap-southeast-2"
  }
}