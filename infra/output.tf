# Net module output
output "vpc" {
  value = "${module.network.vpc}"
}
output "sn_pub1" {
  value = "${module.network.sn_pub1}"
}
output "sn_pub2" {
  value = "${module.network.sn_pub2}"
}
output "sn_pub3" {
  value = "${module.network.sn_pub3}"
}
output "sn_priv1" {
  value = "${module.network.sn_priv1}"
}
output "sn_priv2" {
  value = "${module.network.sn_priv2}"
}
output "sn_priv3" {
  value = "${module.network.sn_priv3}"
}
# Sec module output
output "sg_web" {
  value = "${module.security.sg_web}"
}
output "sg_db" {
  value = "${module.security.sg_db}"
}
output "sg_alb" {
  value = "${module.security.sg_alb}"
}
output "sg_consul" {
  value = "${module.security.sg_consul}"
}
output "sg_vault" {
  value = "${module.security.sg_vault}"
}