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

variable "SUBNET_CIDR_CLUSTER_1" {
}
variable "SUBNET_CIDR_CLUSTER_2" {
}
variable "ZONE_SUB_CLUSTER_1" {
}
variable "ZONE_SUB_CLUSTER_2" {
}
variable "ZONE_SUB_CLUSTER_3" {
}
variable "ZONE_SUB_CLUSTER_4" {
}
variable "ZONE_SUB_CLUSTER_5" {
}
variable "ZONE_SUB_CLUSTER_6" {
}
variable "ZONE_SUB_CLUSTER_7" {
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