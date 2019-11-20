resource "aws_security_group" "infra-webserver" {
  name        = "webserver"
  description = "Allow HTTP from Anywhere"
  vpc_id      = "${var.vpc_id}"
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
    ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "infra-webserver"
    Site = "infra-web-site"
  }
}
resource "aws_security_group" "infra-database" {
  name        = "database"
  description = "Allow infraSQL/Aurora from WebService"
  vpc_id      = "${var.vpc_id}"
  ingress {
    from_port       = 3306
    to_port         = 3306
    protocol        = "tcp"
    security_groups = ["${aws_security_group.infra-webserver.id}"]
    self            = false
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "infra-database"
    Site = "infra-web-site"
  }
}