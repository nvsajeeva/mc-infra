
resource "aws_security_group" "mc-ghost-sg" {
  vpc_id = aws_vpc.demo.id

  ingress {
    description      = "traffic from outside"
    from_port        = 443
    to_port          = 443
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
  ingress {
      from_port = 0
      to_port = 0
      protocol = -1
      self = true
  }
 ingress {
    description      = "traffic from outside"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
   ingress {
    description      = "traffic from outside"
    from_port        = 8080
    to_port          = 8080
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
  ingress {
    description      = "traffic from outside"
    from_port        = 8085
    to_port          = 8085
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = tomap({
    "Name"                                      = "mc-ghost-sg"
  })
}

resource "aws_security_group" "mc-rds-sg" {
  vpc_id = aws_vpc.demo.id

  ingress {
    description      = "traffic from outside"
    from_port        = 3306
    to_port          = 3306
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
  ingress {
      from_port = 0
      to_port = 0
      protocol = -1
      self = true
  }
 
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = tomap({
    "Name"                                      = "mc-rds-sg"
  })
}