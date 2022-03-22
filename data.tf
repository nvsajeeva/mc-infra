data "aws_subnets" "example" {
  filter {
    name   = "vpc-id"
    values = [aws_vpc.demo.id]
  }
}
output "first_subnet_id" {
    value = data.aws_subnets.example.ids[0]
}