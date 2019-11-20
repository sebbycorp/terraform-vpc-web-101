data "aws_ami" "amazon-linux-2" {
  most_recent = true
  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
  filter {
    name   = "architecture"
    values = ["x86_64"]
  }
  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-2.0*"]
  }
  owners = ["137112412989"] # Amazon
}