resource "aws_security_group" "tf_jenkins_project" {
  name        = "tf_jenkins_project"
  description = "tf_jenkins_project sg"

  ingress {
    description      = "Allow 8080"
    from_port        = 8080
    to_port          = 8080
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  ingress {
    description      = "Allow SSH"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  tags = {
    Name = "allow_tls"
  }
}

resource "aws_instance" "tf_jenkins_project" {
  ami                    = var.ami
  instance_type          = var.instance_type
  subnet_id              = var.subnet
  security_groups        =[aws_security_group.tf_jenkins_project.id]
  key_name               = "keyname"
    tags = {
    Name = "tf_jenkins_project"
  }
}
