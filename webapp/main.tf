module "instances" {
  source = "./app"
  sg_web = "${var.sg_web}"
  sn_web = "${var.sn_web}"
  key_name = "${var.key_name}"
}