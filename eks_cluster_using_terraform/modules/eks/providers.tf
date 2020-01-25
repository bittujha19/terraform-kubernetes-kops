#
# Provider Configuration

provider "aws" {
  region = "${var.aws-region}"
  access_key = "ACCESS_KEY"
  secret_key = "SECRET_KEY"
}
# generic for any region.
data "aws_region" "current" {}

data "aws_availability_zones" "available" {}

provider "http" {}
