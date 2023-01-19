resource "aws_alb" "nginx_alb" {
  internal = false
  name = "${var.aws_lb_project}-alb"
  security_groups = [aws_security_group.class-nginx-lb-sg.id]
  subnets = ["subnet-0ee719433e9ce8ecb","subnet-0b482f3f4e26d23fb"]
}

resource "aws_alb_target_group" "nginx_target_group" {
    name = "${var.aws_lb_project}-target-group"
    port = 80
    protocol = "HTTP"
    target_type = "instance" # This is default
    vpc_id = "vpc-0f27b8fe4a7ac492c"
}

# Registering EC2 instance
resource "aws_alb_target_group_attachment" "nginx_target_group_attachment" {
  count = length(aws_instance.class-ec2-server)
  target_group_arn = aws_alb_target_group.nginx_target_group.arn
  target_id = aws_instance.class-ec2-server[count.index].id
  port = 80
}

# Create ALB Listner
resource "aws_alb_listener" "nginx_alb_listner" {
    load_balancer_arn = aws_alb.nginx_alb.arn
    port = 80
    protocol = "HTTP"

    default_action {
      type = "forward"
      target_group_arn = aws_alb_target_group.nginx_target_group.arn
    }
}
