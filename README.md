# Terraform EC2 in Private Subnet

This Terraform project creates an EC2 instance in a private subnet within a VPC using a modular approach.

## Architecture

The infrastructure consists of:
- A VPC with public and private subnets
- Internet Gateway for the public subnet
- NAT Gateway for the private subnet to access the internet
- EC2 instance deployed in the private subnet
- Security groups for the EC2 instance

## Module Structure

```
.
├── main.tf           # Root module that calls the VPC and EC2 modules
├── variables.tf      # Input variables for the root module
├── outputs.tf        # Outputs from the root module
├── terraform.tfvars  # Example variable values
└── modules/
    ├── vpc/          # VPC module
    │   ├── main.tf
    │   ├── variables.tf
    │   └── outputs.tf
    └── ec2/          # EC2 module
        ├── main.tf
        ├── variables.tf
        └── outputs.tf
```

## Usage

1. Initialize Terraform:
```
terraform init
```

2. Review the execution plan:
```
terraform plan
```

3. Apply the configuration:
```
terraform apply
```

4. To destroy the resources:
```
terraform destroy
```

## Customization

You can customize the deployment by modifying the variables in `terraform.tfvars` or by passing them directly to the `terraform apply` command:

```
terraform apply -var="instance_type=t3.micro" -var="region=us-west-2"
```

## Notes

- The EC2 instance is deployed in a private subnet and doesn't have direct internet access
- Access to the EC2 instance is only possible through a bastion host or AWS Systems Manager
- The NAT Gateway allows the EC2 instance to access the internet for updates and downloads
