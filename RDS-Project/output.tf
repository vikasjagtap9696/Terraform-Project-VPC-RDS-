output "rds_instance_identifier" {
  description = "The identifier of the RDS instance"
  value       = aws_db_instance.default.id
}

output "rds_endpoint" {
  description = "The connection endpoint address of the RDS instance"
  value       = aws_db_instance.default.endpoint
}

output "rds_address" {
  description = "The hostname of the RDS instance"
  value       = aws_db_instance.default.address
}

output "rds_port" {
  description = "The port of the RDS instance"
  value       = aws_db_instance.default.port
}

output "rds_security_group_id" {
  description = "The ID of the security group attached to the RDS instance"
  value       = aws_security_group.rds_sg.id
}

output "rds_subnet_group_name" {
  description = "The name of the DB subnet group"
  value       = aws_db_subnet_group.rds_subnet_group.name
}
