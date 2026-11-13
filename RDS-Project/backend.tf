terraform {
  backend "s3" {
    bucket       = "terrfrom-vikas-rds"
    key          = "prod/terraform.tfsate"
    encrypt      = true
    use_lockfile = true

    region = "ap-south-1"
  }
}
