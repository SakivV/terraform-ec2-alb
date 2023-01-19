resource "aws_security_group" "class-ec2-server-sg" {
  name        = "${var.aws_lb_project}-ec2-security-group"
  description = "EC2 Security group"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["94.213.52.135/32"] #Change IP Address as per your need
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    #cidr_blocks = ["0.0.0.0/0"]
    security_groups = [aws_security_group.class-nginx-lb-sg.id] #Change IP Address as per your need
  }
  egress {
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
    from_port        = 0
    to_port          = 0
    protocol         = -1
  }
  
}

resource "aws_security_group" "class-nginx-lb-sg" {
  name        = "${var.aws_lb_project}-lb-security-group"
  description = "NGINX Securiy group"

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
    from_port        = 0
    to_port          = 0
    protocol         = -1
  }
}
