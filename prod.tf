provider "aws" {
    profile = "terraform"
    region  = "eu-west-2"
}

resource "aws_s3_bucket" "prod_tf_course" {
    bucket = "tf-course-joes-20200910"
    acl    = "private"
}

resource "aws_default_vpc" "default" {}


resource "aws_default_subnet" "default_az1" {
  availability_zone = "eu-west-2a"

  tags = {
    "Terraform" : "true"
  }
}

resource "aws_default_subnet" "default_az2" {
  availability_zone = "eu-west-2b"

  tags = {
    "Terraform" : "true"
  }
}

resource "aws_security_group" "prod_web" {
  name        = "prod_web"
  description = "Allow standard http and httpd ports inbound and everything outbound"


  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    # cidr_blocks = ["212.159.77.242/32"]
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    # cidr_blocks = ["212.159.77.242/32"]
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    "Terraform" : "true"
  }
}


resource "aws_instance" "prod_web" {
  count         = 2

  ami           = "ami-0bb4ccae20b00128d"
  instance_type = "t2.medium"

  vpc_security_group_ids = [
    aws_security_group.prod_web.id
  ]

  tags = {
    "Terraform" : "true"
  }
}


resource "aws_eip_association" "prod_web" {
  instance_id   = aws_instance.prod_web.0.id
  allocation_id =  aws_eip.prod_web.id

}


# static ip
resource "aws_eip" "prod_web" {
  tags = {
    "Terraform" : "true"
  }

}

resource "aws_elb" "prod_web" {
  name            = "prod-web"
  instances       =  aws_instance.prod_web.*.id
  subnets         = [aws_default_subnet.default_az1.id, aws_default_subnet.default_az2.id]
  security_groups = [aws_security_group.prod_web.id]

  listener {
    instance_port     = 80
    instance_protocol = "http"
    lb_port           = 80
    lb_protocol       = "http"
  }
  tags = {
    "Terraform" : "true"
  }
}
