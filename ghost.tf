/*
resource "aws_instance" "ghost" {
  subnet_id               = data.aws_subnets.example.ids[0]
  ami                     = "ami-0c02fb55956c7d316"
  key_name                = module.aws-keypair.key_name
  instance_type           = "t2.micro"
  vpc_security_group_ids      = [aws_default_security_group.default.id]
  disable_api_termination = false
  #user_data               = "${file("install_ghost.sh")}"
  tags = {
    Name   = "ghost-instance"
    Owner = "mc-devops"
  }

}
*/