data "aws_ami" "consul" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-bionic-18.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}
resource "aws_instance" "consul1" {
  ami           = "${data.aws_ami.consul.id}"
  instance_type = "t2.micro"
  key_name      = "${var.key_name}"
  subnet_id     = "${var.sn_web}"
  user_data     = "${file("${path.module}/consul.sh")}"
  associate_public_ip_address = true
vpc_security_group_ids = [
    "${var.sg_consul}",
  ]
  tags = {
    "Name" = "infra-consul1"
    "Site" = "infra-consul1-site"
  }
}
resource "aws_instance" "consul2" {
  ami           = "${data.aws_ami.consul.id}"
  instance_type = "t2.micro"
  key_name      = "${var.key_name}"
  subnet_id     = "${var.sn_web2}"
  user_data     = "${file("${path.module}/consul.sh")}"
  associate_public_ip_address = true
vpc_security_group_ids = [
    "${var.sg_consul}",
  ]
  tags = {
    "Name" = "infra-consul2"
    "Site" = "infra-consul2-site"
  }
}
resource "aws_instance" "consul3" {
  ami           = "${data.aws_ami.consul.id}"
  instance_type = "t2.micro"
  key_name      = "${var.key_name}"
  subnet_id     = "${var.sn_web3}"
  user_data     = "${file("${path.module}/consul.sh")}"
  associate_public_ip_address = true
vpc_security_group_ids = [
    "${var.sg_consul}",
  ]
  tags = {
    "Name" = "infra-consul3"
    "Site" = "infra-consul3-site"
  }
}
