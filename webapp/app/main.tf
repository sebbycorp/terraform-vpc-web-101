data "aws_ami" "nginx" {
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
resource "aws_instance" "nginx" {
  ami           = "${data.aws_ami.nginx.id}"
  instance_type = "t2.micro"
  key_name      = "${var.key_name}"
  subnet_id     = "${var.sn_web}"
  user_data     = "${file("${path.module}/nginx.sh")}"
  associate_public_ip_address = true
vpc_security_group_ids = [
    "${var.sg_web}",
  ]
  tags = {
    "Name" = "infra-webserver"
    "Site" = "infra-web-site"
  }
}