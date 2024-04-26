# Task_2-InterCareer_Terraform
==================== Terraform ==================================
Terraform is from HCL
terraform.io
https://registry.terraform.io/browse/providers  --> providers list
Terraform --> IAC

# terraform init --> Initialize for specific provider, which is in terrascript and 
                     downloads dependencies related to that provider
# terraform validate --> Validates Terrascript written for launching resource in provider 
                         (static syntax check)
# terraform plan --> Generates Plan of resource launching based on terrascript written
# terraform apply --> Launches resource in specific provieder and stories info in statefile
# terraform destroy --> (will delete / terminate the created one -- will delete last from state)
                        it takes info from statefile, i.e deletes latest/last launched resources


Linux
-----
bin  --> normal user(ec2-user, centos) executes commands present in bin dir
sbin --> Admin (root) user executes commands from sbin dir


===================Terraform Installation =========================

AMI : CentOS Linux 7 x86_64 HVM EBS ENA 1901_01-b7ee8a69-ee97-4a49-9e68-afaee216db2e-ami-05713873c6794f575.4
update OS

# yum update -y

Download terraform and make it executable and copt to /usr/bin and /usr/sbin dir

curl -O https://releases.hashicorp.com/terraform/0.12.18/terraform_0.12.18_linux_amd64.zip
curl -O https://releases.hashicorp.com/terraform/0.14.11/terraform_0.14.11_linux_amd64.zip

present --> 1.3.x

unzip

# yum install unzip --> installing unzip package

# unzip terraform_0.12.18_linux_amd64.zip

terraform dir will be created

check version of terraform which is installed (before copy to bin or sbin)
# terraform --version

# cp terraform /usr/bin 
# cp terraform /usr/sbin
# cp terraform /usr/local/bin

check version of terraform which is installed (After Copy)
# terraform --version

-------------------------- Configure AWS CLI -----------------
check python version
# python --version

pip tool installation for linux

# curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py
# python get-pip.py
# pip install awscli --> for install aws cli

Configure AWS 
# aws configure

check conectivity to AWS CLI
# aws s3 ls

Now install boto with pip for managing AWS infra
# pip install boto --user


---------------------------- Creating Sample EC2 Infra -----------
vi ec2.tf

provider "aws" {
 profile = "default"
 region = "ap-northeast-1"
}

resource "aws_instance" "myec2" {
  ami = "<copy value from aws console>" 
  instance_type = "t2.micro"
  subnet_id = "<copy subnet value from aws console>"
  security_groups = ["<copy value from aws console>"]
}

# terraform init
# terraform validate
# terraform plan
# terraform apply
# terraform destroy --> to destroy (delete / terminate resource created in last)

#vi ec2.tf

provider "aws" {
 profile = "default"
 region = "ap-northeast-1"
}

resource "aws_instance" "myec2" {
  ami = "<copy value from aws console>" 
  instance_type = "t2.micro"
  subnet_id = "<copy subnet value from aws console>"
  security_groups = ["<copy value from aws console>"] 
  user_data = <<-EOT
             #! /bin/bash
             cd /tmp
             sudo yum install -y https://s3.amazonaws.com/ec2-downloads-windows/SSMAgent/latest/linux_amd64/amazon-ssm-agent.rpm
             systemctl start amazon-ssm-agent
             systemctl enable amazon-ssm-agent
  EOT

  tags = {
     Name = "my-ssm"
   }
  iam_instance_profile = "ssmrole"
}


--------- Till Now we taken existing resources (VPC, Subnet, Security Groups etc)------------------------
--------- Now will create every resource as new ---------------------


vi mynewec2.tf

provider "aws" {
 profile = "default"
 region = "ap-northeast-1"
}

resource "aws_vpc" "myvpc" {
  cidr_block = "192.168.4.0/24"
  tags = {
     Name = "myvpc"
  }
}

resource "aws_subnet" "mysubnet" {
  vpc_id = "${aws_vpc.myvpc.id}"
  cidr_block = "192.168.4.0/25"
  tags = {
     Name = "mysubnet"
   }
}


resource "aws_security_group" "mysg" {
   vpc_id = "${aws_vpc.myvpc.id}"
   tags = {
   	Name = "mysg"
   }  
   ingress {
      protocol = "tcp"
      from_port = 22
      to_port = 22
      cidr_blocks = ["0.0.0.0/0"]
   }
   egress {
      protocol = "tcp"
      from_port = 0
      to_port = 0
      cidr_blocks = ["0.0.0.0/0"]
   }
}

resource "aws_instance" "myec2" {
  ami = "<copy value from aws console>" 
  instance_type = "t2.micro"
  subnet_id = "<copy subnet value from aws console>"
  security_groups = ["<copy value from aws console>"] 
  user_data = <<-EOT
             #! /bin/bash
             cd /tmp
             sudo yum install -y https://s3.amazonaws.com/ec2-downloads-windows/SSMAgent/latest/linux_amd64/amazon-ssm-agent.rpm
             systemctl start amazon-ssm-agent
             systemctl enable amazon-ssm-agent
  EOT

  tags = {
     Name = "my-ssm"
   }
  iam_instance_profile = "ssmrole"
}




