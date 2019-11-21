module "instances" {
  source = "./app"
  sg_web = "var.sg_web"
  sn_web = "var.sn_web"
  sn_web2 = "var.sn_web2"
  sn_web3 = "var.sn_web3"
  key_name = "var.key_name"
  sg_alb = "var.sg_alb"
}
module "consulinstances" {
  source = "./consul"
  sn_web = "var.sn_web"
  sn_web2 = "var.sn_web2"
  sn_web3 = "var.sn_web3"
  key_name = "var.key_name"
  sg_consul = "var.sg_consul"
}