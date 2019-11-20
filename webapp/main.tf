module "instances" {
  source = "./app"
  sg_web = "${var.sg_web}"
  sn_web = "${var.sn_web}"
  sn_web2 = "${var.sn_web2}"
  key_name = "${var.key_name}"
}