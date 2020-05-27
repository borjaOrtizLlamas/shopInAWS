variable "ZONE" {
  default = "eu-west-1"
} 
variable "TERRAFORM_USER_ID" {
}
variable "TERRAFORM_USER_PASS" {
}
variable "ZONE_SUB" {
  default = "eu-west-1b"
}
variable "MONGO_SSH_KEY" {
}

variable "SUBNET_CIDR_APLICATIONS" {
}

variable "SUBNET_CIDR_CLUSTER" {
}

variable "NET_CIDR_BLOCK" {
}
variable "SUFIX" {
}

#our provider
provider "aws" {
  region     = "${var.ZONE}"
  access_key = "${var.TERRAFORM_USER_ID}"
  secret_key = "${var.TERRAFORM_USER_PASS}"
}