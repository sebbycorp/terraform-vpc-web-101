#### VARIABLES
variable "profile" {
  default = "default"
}
variable "region" {
  default = "us-east-1"
}
variable "key_name" {
  default = "aws-key-sebby"
}
#### CALL MDOULES
module "core_infra" {
  source = "./infra"
}
module "webapp" {
  source   = "./webapp"
  profile  = "${var.profile}"
  region   = "${var.region}"
  key_name = "${var.key_name}"
  # pass web security group and public networks
  sg_web    = "${module.core_infra.sg_web}"
  sg_consul = "${module.core_infra.sg_consul}"
  sn_web    = "${module.core_infra.sn_pub1}"
  sn_web2   = "${module.core_infra.sn_pub2}"
  sn_web3   = "${module.core_infra.sn_pub3}"
  sg_alb    = "${module.core_infra.sg_alb}"
}