
# Default VPC
data "aws_vpc" "default" {
  default = true
}

data "aws_subnets" "default" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.default.id]
  }
}

# Security group for RDS
resource "aws_security_group" "rds_sg" {
  name        = var.rds_security_group_name
  description = var.rds_security_group_description
  vpc_id      = data.aws_vpc.default.id

  ingress {
    from_port   = var.rds_ingress_from_port
    to_port     = var.rds_ingress_to_port
    protocol    = var.rds_ingress_protocol
    cidr_blocks = var.rds_ingress_cidr_blocks
  }

  egress {
    from_port   = var.rds_egress_from_port
    to_port     = var.rds_egress_to_port
    protocol    = var.rds_egress_protocol
    cidr_blocks = var.rds_egress_cidr_blocks
  }

  tags = {
    Name = var.rds_security_group_name
  }
}

# Subnet group for RDS
resource "aws_db_subnet_group" "rds_subnet_group" {
  name       = var.rds_subnet_group_name
  subnet_ids = data.aws_subnets.default.ids

  tags = {
    Name = var.rds_subnet_group_name
  }
}

# RDS instance
resource "aws_db_instance" "default" {
  allocated_storage      = var.allocated_storage
  engine                 = var.db_engine
  engine_version         = var.db_engine_version
  instance_class         = var.db_instance_class
  db_name                = var.db_name
  username               = var.db_username
  password               = var.db_password
  parameter_group_name   = "${var.db_parameter_group_prefix}.${var.db_engine}${var.db_engine_pggroup}"  # Adjust if needed
  db_subnet_group_name   = aws_db_subnet_group.rds_subnet_group.name
  vpc_security_group_ids = [aws_security_group.rds_sg.id]

  # Backup and maintenance settings
  backup_retention_period = var.db_backup_retention_period
  backup_window           = var.db_backup_window
  maintenance_window      = var.db_maintenance_window

  skip_final_snapshot = var.skip_final_snapshot  # Skip final snapshot on deletion (for testing purposes)

  tags = {
    Name = var.rds_instance_name
  }
}