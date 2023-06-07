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

resource "tls_private_key" "generated" {
  algorithm = "RSA"
}

resource "aws_key_pair" "generated" {
  key_name   = "jenkins_key"
  public_key = tls_private_key.generated.public_key_openssh
}

resource "local_file" "privated_key_pem" {
  content  = tls_private_key.generated.private_key_pem
  filename = "jenkins_key.pem"
}

resource "aws_instance" "tf_jenkins_project" {
  ami                    = var.ami
  instance_type          = var.instance_type
  subnet_id              = var.subnet
  security_groups        =[aws_security_group.tf_jenkins_project.id]
  key_name               = aws_key_pair.generated.key_name
    tags = {
    Name = "tf_jenkins_project"
  }
  connection {
    type        = "ssh"
    user        = "ec2-user"
    private_key = tls_private_key.generated.private_key_pem
    host        = self.public_ip
  }
  provisioner "remote-exec" {
    inline = [
     "sudo yum update -y",
     "sudo yum install java-1.8.0-openjdk",
     "sudo wget -O /etc/yum.repos.d/jenkins.repo https://pkg.jenkins.io/redhat/jenkins.repo",
     "sudo rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io.key",
     "sudo yum install jenkins",
     "sudo systemctl enable jenkins",
     "sudo systemctl start jenkins",
     "sudo systemctl status jenkins",
     ]
   } 
}


