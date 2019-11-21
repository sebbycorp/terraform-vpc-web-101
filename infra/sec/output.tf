output "sg_web" {
  value = "${aws_security_group.infra-webserver.id}"
}
output "sg_db" {
  value = "${aws_security_group.infra-database.id}"
}
output "sg_alb" {
  value = "${aws_security_group.infra-alb.id}"
}
output "sg_consul" {
  value = "${aws_security_group.infra-consul.id}"
}
