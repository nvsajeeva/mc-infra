variable "aws_region" {
  default = "us-east-1"
}

variable "keypair_name" {
  description = "KeyPair Name"
  default     = "mc-keypair"
}
variable "mysql_engine_version" {
  type        = string
  default     = "8.0"
}

variable "mysql_instance_class" {
  type    = string
  default = "db.t3.micro"
}

variable "instance_name" {
  type    = string
  default = "ghostdb"
}

variable "mysql_parameter_group_name" {
  type    = string
  default = "default.mysql8.0"
}
variable "ec2_instance_type" {
  type    = string
  default = "t3.micro"
}

variable "asg_max_size" {
  type    = string
  default = 1
}

variable "asg_min_size" {
  type    = string
  default = 1
}
variable "origin_id" {
  default = "mc-ghost-origin"
  
}
variable "origin_id_2" {
  default = "mc-node-origin"
  
}
variable "cert" {
  default = "arn:aws:acm:us-east-1:582715569472:certificate/9ac2ac15-cb25-48be-82df-11d4e885bfd4"
  
}