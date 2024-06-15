# Create a load balancer
resource "aws_lb" "web_lb" {
  name               = "web-lb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.web_sg.id]
  subnets            = [aws_subnet.main_b.id, aws_subnet.main_c.id]
}

# Create target group
resource "aws_lb_target_group" "web_tg" {
  name     = "web-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.main.id

  health_check {
    interval            = 30
    path                = "/"
    protocol            = "HTTP"
    timeout             = 5
    healthy_threshold   = 2
    unhealthy_threshold = 2
  }
}

# Create load balancer listener
resource "aws_lb_listener" "web_lb_listener" {
  load_balancer_arn = aws_lb.web_lb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.web_tg.arn
  }
}

# Register targets with the target group
resource "aws_lb_target_group_attachment" "production_environment_1" {
  target_group_arn = aws_lb_target_group.web_tg.arn
  target_id        = aws_instance.production_environment_1.id
  port             = 80
}

resource "aws_lb_target_group_attachment" "production_environment_2" {
  target_group_arn = aws_lb_target_group.web_tg.arn
  target_id        = aws_instance.production_environment_2.id
  port             = 80
}
