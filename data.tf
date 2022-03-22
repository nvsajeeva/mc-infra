data "aws_subnets" "example" {
  filter {
    name   = "vpc-id"
    values = [aws_vpc.demo.id]
  }
}