output "sg_web" {
  value = "${aws_security_group.infra-webserver.id}"
}
output "sg_db" {
  value = "${aws_security_group.infra-database.id}"
}