resource "aws_db_instance" "mc-rds" {
  allocated_storage      = 20
  storage_type           = "gp2"
  engine                 = "mysql"
  engine_version         = var.mysql_engine_version        
  instance_class         = var.mysql_instance_class
  username                    = local.db_creds.username
  password                    = local.db_creds.password
  db_subnet_group_name   = aws_db_subnet_group.default.name
  parameter_group_name   = var.mysql_parameter_group_name
  vpc_security_group_ids = [aws_security_group.mc-rds-sg.id]
  publicly_accessible    = true
  skip_final_snapshot    = true
  final_snapshot_identifier = "mc-rds-final"
tags = tomap({
    "Name"                                      = "mc-rds"
  })
}

resource "aws_db_subnet_group" "default" {
  name       = "main"
  subnet_ids = [aws_subnet.demo[0].id, aws_subnet.demo[1].id]
}