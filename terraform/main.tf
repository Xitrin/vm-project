provider "aws" {
  region = "us-east-1"
}
data "aws_security_group" "sg" {
  filter {
    name   = "group-name"
    values = ["MySecurityGroup"]
  }
}

resource "aws_instance" "nginx_ec2" {
  ami           = "ami-0ebfd941bbafe70c6"
  instance_type = "t2.micro"
  key_name      = "MyKeyPair"
  vpc_security_group_ids = [data.aws_security_group.sg.id]

  tags = {
    Name = "terraform-nginx"
  }

  user_data = <<-EOF
                #!/bin/bash
                sudo yum update -y
                sudo yum install -y nginx
                sudo systemctl start nginx
                sudo systemctl enable nginx
            EOF
}

output "instance_ip" {
  value = aws_instance.nginx_ec2.public_ip
}
