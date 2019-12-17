data "aws_ami" "vault" {
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
resource "aws_instance" "vault1" {
  ami           = "${data.aws_ami.vault.id}"
  instance_type = "t2.micro"
  key_name      = "${var.key_name}"
  subnet_id     = "${var.sn_web}"
  user_data     = "${file("${path.module}/vault.sh")}"
  associate_public_ip_address = true
vpc_security_group_ids = [
    "${var.sg_vault}",
  ]
  tags = {
    "Name" = "infra-vault1"
    "Site" = "infra-vault1-site"
  }
}
resource "aws_instance" "vault2" {
  ami           = "${data.aws_ami.vault.id}"
  instance_type = "t2.micro"
  key_name      = "${var.key_name}"
  subnet_id     = "${var.sn_web2}"
  user_data     = "${file("${path.module}/vault.sh")}"
  associate_public_ip_address = true
vpc_security_group_ids = [
    "${var.sg_vault}",
  ]
  tags = {
    "Name" = "infra-vault2"
    "Site" = "infra-vault2-site"
  }
}
resource "aws_instance" "vault3" {
  ami           = "${data.aws_ami.vault.id}"
  instance_type = "t2.micro"
  key_name      = "${var.key_name}"
  subnet_id     = "${var.sn_web3}"
  user_data     = "${file("${path.module}/vault.sh")}"
  associate_public_ip_address = true
vpc_security_group_ids = [
    "${var.sg_vault}",
  ]
  tags = {
    "Name" = "infra-vault3"
    "Site" = "infra-vault3-site"
  }
}
