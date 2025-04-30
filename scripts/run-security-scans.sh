#!/bin/bash

# Script to run security scans on Terraform code

set -e

echo "Running Terraform security scans..."

# Check if tools are installed
check_tool() {
  if ! command -v $1 &> /dev/null; then
    echo "$1 is not installed. Please install it first."
    echo "Visit: $2"
    exit 1
  fi
}

check_tool tfsec "https://github.com/aquasecurity/tfsec"
check_tool checkov "https://github.com/bridgecrewio/checkov"
check_tool terrascan "https://github.com/accurics/terrascan"

# Create output directory
mkdir -p security-reports

echo "Running tfsec..."
tfsec . --format json > security-reports/tfsec-report.json || true
echo "tfsec scan complete. Report saved to security-reports/tfsec-report.json"

echo "Running checkov..."
checkov -d . --output json > security-reports/checkov-report.json || true
echo "checkov scan complete. Report saved to security-reports/checkov-report.json"

echo "Running terrascan..."
terrascan scan -d . -o json -i terraform > security-reports/terrascan-report.json || true
echo "terrascan scan complete. Report saved to security-reports/terrascan-report.json"

echo "All security scans completed. Reports are available in the security-reports directory."

# Count issues found
TFSEC_COUNT=$(grep -c "results" security-reports/tfsec-report.json || echo 0)
CHECKOV_COUNT=$(grep -c "check_id" security-reports/checkov-report.json || echo 0)
TERRASCAN_COUNT=$(grep -c "rule_id" security-reports/terrascan-report.json || echo 0)

echo "Summary of findings:"
echo "- tfsec: $TFSEC_COUNT issues"
echo "- checkov: $CHECKOV_COUNT issues"
echo "- terrascan: $TERRASCAN_COUNT issues"

echo "Please review the reports and address any security issues before committing your code."