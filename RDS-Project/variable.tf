variable "region" {
  description = "The AWS region to deploy resources in"
  type        = string
  default     = "ap-south-1"
}

variable "db_instance_class" {
  description = "The instance type for the RDS instance"
  type        = string
  default     = "db.t3.micro"
}

variable "db_name" {
  description = "The name of the database to be created"
  type        = string
  default     = "mydatabase"
}

variable "db_engine" {
  description = "The database engine to use"
  type        = string
  default     = "postgres"
}

variable "db_engine_version" {
  description = "The version of the database engine"
  type        = string
  default     = "15.7"
}
variable "db_engine_pggroup" {
  description = "The version of the parameter group"
  type        = string
  default     = "15"
}
variable "db_username" {
  description = "The master username for the RDS instance"
  type        = string
  default     = "reyaz"
}

variable "db_password" {
  description = "The master password for the RDS instance"
  type        = string
}

variable "allocated_storage" {
  description = "The allocated storage in GB"
  type        = number
  default     = 20
}

variable "db_backup_retention_period" {
  description = "The number of days to retain backups"
  type        = number
  default     = 7
}

variable "db_backup_window" {
  description = "The daily time range during which automated backups are created"
  type        = string
  default     = "03:00-04:00"
}

variable "db_maintenance_window" {
  description = "The weekly time range during which system maintenance can occur"
  type        = string
  default     = "sun:05:00-sun:06:00"
}

variable "rds_security_group_name" {
  description = "The name of the RDS security group"
  type        = string
  default     = "rds_security_group"
}

variable "rds_security_group_description" {
  description = "The description of the RDS security group"
  type        = string
  default     = "Security group for RDS instance"
}

variable "rds_ingress_from_port" {
  description = "The starting port for inbound RDS traffic"
  type        = number
  default     = 5432
}

variable "rds_ingress_to_port" {
  description = "The ending port for inbound RDS traffic"
  type        = number
  default     = 5432
}

variable "rds_ingress_protocol" {
  description = "The protocol for inbound RDS traffic"
  type        = string
  default     = "tcp"
}

variable "rds_ingress_cidr_blocks" {
  description = "The CIDR blocks allowed for inbound RDS traffic"
  type        = list(string)
  default     = ["0.0.0.0/0"]
}

variable "rds_egress_from_port" {
  description = "The starting port for outbound RDS traffic"
  type        = number
  default     = 0
}

variable "rds_egress_to_port" {
  description = "The ending port for outbound RDS traffic"
  type        = number
  default     = 0
}

variable "rds_egress_protocol" {
  description = "The protocol for outbound RDS traffic"
  type        = string
  default     = "-1"
}

variable "rds_egress_cidr_blocks" {
  description = "The CIDR blocks allowed for outbound RDS traffic"
  type        = list(string)
  default     = ["0.0.0.0/0"]
}

variable "rds_subnet_group_name" {
  description = "The name of the RDS subnet group"
  type        = string
  default     = "rds_subnet_group"
}

variable "db_parameter_group_prefix" {
  description = "The prefix used for the RDS parameter group name"
  type        = string
  default     = "default"
}

variable "skip_final_snapshot" {
  description = "Whether to skip the final snapshot when deleting the RDS instance"
  type        = bool
  default     = true
}

variable "rds_instance_name" {
  description = "The name tag for the RDS instance"
  type        = string
  default     = "terraform-rds-instance"
}