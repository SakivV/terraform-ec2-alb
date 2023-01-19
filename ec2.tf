resource "aws_instance" "class-ec2-server" {
  instance_type = var.ec2_instance_type #Refer value from ec2_instance_type variable
  ami = data.aws_ami.ec2_ami_image.id
  vpc_security_group_ids = [aws_security_group.class-ec2-server-sg.id]
  key_name = "jenkins-slave"
  user_data = file("nginx.sh")
  count = var.ec2_instance_count
  tags = {
    "Name" = "${var.aws_lb_project}-${count.index}"
  }
 
}