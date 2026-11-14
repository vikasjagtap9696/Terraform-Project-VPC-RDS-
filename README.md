# Terraform AWS VPC and RDS Projects

Terraform configurations for provisioning AWS networking, web infrastructure, and a PostgreSQL RDS database. The project is organized into two independent Terraform modules:

- [`VPC-Project`](./VPC-Project) - VPC networking and a small web application stack.
- [`RDS-Project`](./RDS-Project) - PostgreSQL RDS in the AWS default VPC.

> **Important:** The two projects currently use separate Terraform states. The RDS project discovers subnets in the AWS **default VPC**; it does not automatically use the VPC created by `VPC-Project`.

## Architecture

### VPC project

The VPC project provisions:

- A custom VPC using the CIDR configured in `terraform.tfvars`.
- Two subnets in availability zones `ap-south-1a` and `ap-south-1b`.
- An Internet Gateway, route table, and subnet associations.
- A security group allowing HTTP (port 80) and SSH (port 22).
- Two EC2 `t3.micro` web instances using `userdata.sh`.
- An internet-facing Application Load Balancer, target group, attachments, and HTTP listener.
- An S3 bucket.
- An output containing the Application Load Balancer DNS name.

### RDS project

The RDS project provisions:

- A PostgreSQL RDS instance (`db.t3.micro` by default).
- A DB subnet group using all subnets in the AWS default VPC.
- A security group for PostgreSQL traffic on port 5432.
- Automated backup and maintenance window settings.
- Outputs for the instance identifier, endpoint, address, port, security group ID, and subnet group name.

The default configuration uses PostgreSQL engine version `15.19`, 20 GB of storage, and skips the final snapshot when the instance is destroyed.

## Repository structure

```text
.
├── VPC-Project/
│   ├── backend.tf
│   ├── main.tf
│   ├── output.tf
│   ├── provider.tf
│   ├── terraform.tfvars
│   ├── userdata.sh
│   └── variable.tf
├── RDS-Project/
│   ├── backend.tf
│   ├── main.tf
│   ├── output.tf
│   ├── provider.tf
│   ├── terraform.tfvars
│   └── variable.tf
└── README.md
```

## Prerequisites

- An AWS account with permissions to create the resources in the selected region.
- Terraform installed and available on `PATH`.
- AWS credentials configured using the AWS CLI profile, environment variables, or another supported credential provider.
- Existing S3 state buckets configured in each module's `backend.tf`.
- The AWS provider version `6.73.0`, selected by both modules.

The provider region is `ap-south-1` by default. Change the provider and variable configuration together if deploying to another region.

## Configure secrets safely

Do not commit passwords, access keys, or other secrets to Git. The RDS module requires `db_password`; provide it through a local, ignored `.tfvars` file or an environment variable instead of storing it in a tracked file.

For example:

```powershell
terraform plan -var="db_password=REPLACE_WITH_A_SECURE_PASSWORD"
```

Before deploying, review all values in `terraform.tfvars`, especially AMI IDs, S3 bucket names, database credentials, CIDR blocks, and availability zones. If a password has ever been committed, rotate it in AWS and remove it from tracked files.

## Deploy the VPC project

Run these commands from `VPC-Project`:

```bash
terraform init
terraform fmt -check
terraform validate
terraform plan
terraform apply
```

After applying, retrieve the load balancer DNS name:

```bash
terraform output loadbalancerdns
```

## Deploy the RDS project

Run these commands from `RDS-Project`:

```bash
terraform init
terraform fmt -check
terraform validate
terraform plan -var="db_password=REPLACE_WITH_A_SECURE_PASSWORD"
terraform apply -var="db_password=REPLACE_WITH_A_SECURE_PASSWORD"
```

View database connection details with:

```bash
terraform output rds_endpoint
terraform output rds_address
terraform output rds_port
```

The endpoint and address are connection information, not credentials. Keep database credentials in a secure secret manager or local environment.

## Destroy resources

Destroy each project separately from its own directory:

```bash
terraform destroy
```

For the RDS project, confirm that backups or a final snapshot are not required before destroying the instance. The current default sets `skip_final_snapshot = true`, which is suitable only for temporary or learning environments.

## Security considerations

- Restrict RDS ingress to trusted application or VPC CIDR blocks. Do not use `0.0.0.0/0` for production database access.
- Restrict SSH access to a trusted administrator IP range instead of the entire internet.
- Use a strong, unique database password and rotate it regularly.
- Store Terraform state in a private, encrypted S3 bucket with appropriate access controls.
- Review the S3 bucket name and prevent public access.
- Do not commit `.tfstate`, `.tfstate.*`, crash logs, or secret variable files.
- Use a final snapshot and backups for production databases.
- Review AWS costs before applying and destroy learning resources when they are no longer needed.

## Useful commands

```bash
# Format and validate the current module
terraform fmt
terraform validate

# Review planned changes
terraform plan

# Apply approved changes
terraform apply

# Inspect state outputs
terraform output
```

## Learning goals

- Infrastructure as Code with Terraform.
- AWS VPC networking, routing, and security groups.
- EC2 deployment behind an Application Load Balancer.
- PostgreSQL on Amazon RDS.
- Terraform variables, outputs, remote state, and lifecycle operations.
- Secure cloud deployment practices.

## Author

**Vikas Jagtap**

- [LinkedIn](https://www.linkedin.com/in/vikasjagtap9696)
- [GitHub](https://github.com/vikasjagtap9696)
