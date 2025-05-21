provider "aws" {
  region     = "ap-south-1"
  profile    = "default"
}

resource "aws_instance" "myec2" {
  ami = "ami-0e58b56aa4d64231b" 
  instance_type = "t2.micro"
  subnet_id = "subnet-0dc63b0ae86ed36e6"
  security_groups = ["sg-07813107c9c520c87"] 
  tags = {
      Name = "My Terraform"
  }
  key_name = "Pravalika"
}
