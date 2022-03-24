
resource "aws_launch_configuration" "mc_lc" {
  name_prefix     = "mc-lc"
  image_id        = "ami-04505e74c0741db8d"
  security_groups = [aws_security_group.mc-ghost-sg.id]
  instance_type   = var.ec2_instance_type
  iam_instance_profile = "EC2CodeDeploy"
  key_name                = module.aws-keypair.key_name
  #user_data               = "${file("install_ghost.sh")}"
  user_data       = templatefile("install_ghost.sh", 
  {
    endpoint = aws_db_instance.mc-rds.address,
    username = local.db_creds.username,
    password = local.db_creds.password,
    alb_dns = aws_lb.mc_alb.dns_name
  })
  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_autoscaling_group" "mc_asg" {
  name                 = "mc-asg"
  launch_configuration = aws_launch_configuration.mc_lc.name
  max_size             = var.asg_max_size
  min_size             = var.asg_min_size
  vpc_zone_identifier  = [aws_subnet.demo[0].id, aws_subnet.demo[1].id]
  tag {
    key                 = "cd"
    value               = "prod"
    propagate_at_launch = true
  }
  # Associate the ASG with the Application Load Balancer target group.
  target_group_arns = [aws_lb_target_group.mc_lb_tg.arn, aws_lb_target_group.mc_lb_tg_3000.arn]

  lifecycle {
    create_before_destroy = true
  }
}
