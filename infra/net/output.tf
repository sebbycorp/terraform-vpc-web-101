output "vpc" {
  value = "${aws_vpc.infra-main.id}"
}
output "sn_pub1" {
  value = "${aws_subnet.infra-public1.id}"
}
output "sn_pub2" {
  value = "${aws_subnet.infra-public2.id}"
}
output "sn_pub3" {
  value = "${aws_subnet.infra-public3.id}"
}
output "sn_priv1" {
  value = "${aws_subnet.infra-private1.id}"
}
output "sn_priv2" {
  value = "${aws_subnet.infra-private2.id}"
}
output "sn_priv3" {
  value = "${aws_subnet.infra-private3.id}"
}