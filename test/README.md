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

## Security Testing

In addition to functional testing, the CI/CD pipeline includes security scanning of the Terraform code using:

1. **tfsec** - Terraform security scanner
   ```bash
   tfsec .
   ```

2. **checkov** - Policy-as-code scanner
   ```bash
   checkov -d .
   ```

3. **terrascan** - Compliance and security scanner
   ```bash
   terrascan scan -d . -i terraform
   ```

These tools are automatically run as part of the CI/CD pipeline, but you can also run them locally during development.

## Notes

- These tests use `terraform plan` to validate the configuration without actually creating resources
- The EC2 test creates a mock VPC and subnet for testing purposes
- In a real CI/CD pipeline, you might want to use tools like Terratest or Kitchen-Terraform for more comprehensive testing
- Security scanning helps identify potential security issues before deployment