# Security Scanning Tools

This document provides information about the security scanning tools used in this project and how to use them.

## Tools Overview

### tfsec

[tfsec](https://github.com/aquasecurity/tfsec) is a static analysis security scanner for Terraform code.

**Installation:**
```bash
# Using Homebrew
brew install tfsec

# Using Go
go install github.com/aquasecurity/tfsec/cmd/tfsec@latest

# Using Docker
docker run --rm -it -v "$(pwd):/src" aquasec/tfsec /src
```

**Usage:**
```bash
# Basic scan
tfsec .

# Output in JSON format
tfsec . --format json > tfsec-report.json

# Ignore specific checks
tfsec . --exclude AWS123,GCP456
```

### checkov

[checkov](https://github.com/bridgecrewio/checkov) is a static code analysis tool for infrastructure-as-code.

**Installation:**
```bash
# Using pip
pip install checkov

# Using Homebrew
brew install checkov

# Using Docker
docker run --rm -it -v "$(pwd):/src bridgecrew/checkov -d /src
```

**Usage:**
```bash
# Basic scan
checkov -d .

# Output in JSON format
checkov -d . --output json > checkov-report.json

# Skip specific checks
checkov -d . --skip-check CKV_AWS_123,CKV_GCP_456
```

### terrascan

[terrascan](https://github.com/accurics/terrascan) detects compliance and security violations across Infrastructure as Code.

**Installation:**
```bash
# Using Homebrew
brew install terrascan

# Using Docker
docker run --rm -it -v "$(pwd):/src accurics/terrascan scan -d /src

# Using curl
curl -L "$(curl -s https://api.github.com/repos/accurics/terrascan/releases/latest | grep -o -E "https://.+?_Linux_x86_64.tar.gz")" > terrascan.tar.gz
tar -xf terrascan.tar.gz terrascan && rm terrascan.tar.gz
install terrascan /usr/local/bin && rm terrascan
```

**Usage:**
```bash
# Basic scan
terrascan scan -d .

# Output in JSON format
terrascan scan -d . -o json > terrascan-report.json

# Scan specific IaC type
terrascan scan -d . -i terraform
```

## Running Security Scans Locally

This project includes a script to run all security scans locally:

```bash
# Make the script executable
chmod +x scripts/run-security-scans.sh

# Run the script
./scripts/run-security-scans.sh
```

The script will:
1. Check if all required tools are installed
2. Run each security scanning tool
3. Save reports to the `security-reports` directory
4. Provide a summary of findings

## Pre-commit Hooks

This project also includes pre-commit hooks to run security scans automatically before each commit:

1. Install pre-commit:
```bash
pip install pre-commit
```

2. Install the git hooks:
```bash
pre-commit install
```

Now, security scans will run automatically when you commit changes.

## Addressing Security Issues

When security issues are identified:

1. Review the detailed reports in the `security-reports` directory
2. Understand the issue and its potential impact
3. Implement the recommended fix or an alternative solution
4. Re-run the security scans to verify the issue is resolved
5. Document any accepted risks or false positives

## CI/CD Integration

Security scanning is integrated into the CI/CD pipeline. See the [CI/CD Security Scanning documentation](cicd-security-scanning.md) for details.