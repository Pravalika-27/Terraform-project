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
   curl -O https://releases.hashicorp.com/terraform/0.14.11/terraform_0.14.11_linux_amd64.zip
   unzip terraform_<VERSION>_linux_amd64.zip
   sudo mv terraform
   /usr/local/bin/
   /usr/bin/
   /usr/sbin/
5. **Create Directory and Files:**
   ```bash
   mkdir ec2
   cd ec2
6. **Write Terraform Configuration:**
     Populate the .tf files with the appropriate Terraform configuration.
   ```bash
   vi ec2_dep.tf variables.tf
   vi app1_dev.tfvars
   vi app1_uat.tfvars
   vi backend.tf
7. **Create S3 Bucket:**
     Use the AWS Management Console to create an S3 bucket with globally unique name.
8. **Apply Terraform Configuration:**
    ```bash
   terraform apply -var-file=app1_dev.tfvars
9. ** Check Resources on AWS Console:**
      After applying, verify the creation of VPC, subnets, EC2 instances, and S3 bucket on the AWS Management Console.
10. ** Destroy Resources:**
    ```bash
    terraform destroy -var-file=app1_dev.tfvars
11. **Repeat for UAT Environment:**
      Modify the .tfvars file accordingly for UAT environment Repeat steps 8 to 11 with app1_uat.tfvars.

      
      
