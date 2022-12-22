resource "aws_security_group" "tcp_ssh" {
  description = "privete ssh and all tcp"
  vpc_id     = var.vpcid
  ingress {
    description      = "ssh"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    /* cidr_blocks      = ["${chomp(data.http.myip.response_body)}/32"] */
    cidr_blocks      = ["0.0.0.0/0"]

  }

  ingress {
    description      = "tcp"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  ingress {
    description      = "tcp"
    from_port        = 8080
    to_port          = 8080
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  ingress {
    description      = "tcp"
    from_port        = 50000
    to_port          = 50000
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  ingress {
    description      = "tcp"
    from_port        = 4243
    to_port          = 4243
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }
  tags = merge(
    var.tags,
    {
      Name = "${var.enviroment}-sg-${var.vpcname}"
    },
  )  
}

data "http" "myip" {
  url = "http://ipv4.icanhazip.com"
}