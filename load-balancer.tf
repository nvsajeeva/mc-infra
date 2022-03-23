resource "aws_lb" "mc_alb" {
  name               = "mc-alb"
  load_balancer_type = "application"
  security_groups    = [aws_security_group.ghost_lb_sg.id]
  subnets            = [aws_subnet.demo[0].id, aws_subnet.demo[1].id]

  tags = tomap({
    "Name"                                      = "mc-load-balancer"
  })
}

resource "aws_lb_listener" "mc_lb_listener" {
  load_balancer_arn = aws_lb.mc_alb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.mc_lb_tg.arn
  }
}

resource "aws_lb_listener" "securedlistener" {
  load_balancer_arn = aws_lb.mc_alb.arn
  port              = "443"
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-2016-08"
  certificate_arn   = var.cert

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.mc_lb_tg.arn
  }
}

resource "aws_lb_target_group" "mc_lb_tg" {
  name                 = "mc-tg"
  port                 = 80
  protocol             = "HTTP"
  deregistration_delay = 180
  vpc_id               = aws_vpc.demo.id

  health_check {
    healthy_threshold = 3
    interval          = 10
  }

  tags = tomap({
    "Name"                                      = "mc-target-group"
})
}

