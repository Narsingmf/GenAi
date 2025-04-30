# Terraform Module Tests

This directory contains test configurations for the Terraform modules.

## Running the Tests

### VPC Module Test

To test the VPC module:

```bash
cd test
terraform init
terraform plan -target=module.vpc_test
```

### EC2 Module Test

To test the EC2 module:

```bash
cd test
terraform init
terraform plan -target=module.ec2_test
```

## Notes

- These tests use `terraform plan` to validate the configuration without actually creating resources
- The EC2 test creates a mock VPC and subnet for testing purposes
- In a real CI/CD pipeline, you might want to use tools like Terratest or Kitchen-Terraform for more comprehensive testing