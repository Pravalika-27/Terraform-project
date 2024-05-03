# AWS EC2 Deployment with Terraform

This guide outlines the steps to deploy an EC2 instance on AWS using Terraform, along with managing the lifecycle of resources including VPC, subnets, and S3 buckets.

## Prerequisites

- AWS account with appropriate permissions.
- AWS CLI installed and configured.
- SSH key pair for accessing EC2 instances.

## Steps

1. **Launch EC2 Instance:**
   - Use AWS Management Console or AWS CLI to launch an EC2 instance.

2. **Login to EC2 Instance:**
   - SSH into the instance using the key pair you specified during the instance creation.

3. **Configure AWS CLI:**
   - Run `aws configure` and provide necessary AWS access keys and region.

4. **Install Unzip and Terraform:**
   ```bash
   sudo yum install -y unzip
   wget https://releases.hashicorp.com/terraform/<VERSION>/terraform_<VERSION>_linux_amd64.zip
   unzip terraform_<VERSION>_linux_amd64.zip
   sudo mv terraform /usr/local/bin/
5. **Create Directory and Files:**
   ```bash
   mkdir ec2
   cd ec2
   vi ec2_dep.tf variables.tf
   vi app1_dev.tfvars
   vi app1_uat.tfvars
   vi backend.tf
