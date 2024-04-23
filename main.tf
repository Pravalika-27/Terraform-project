provider "aws" {
   region = "us-east-1"
   profile = "default"
}

resource "aws_vpc" "myvpc" {
   tags = {
     Name = "terra-vpc"
   }
   cidr_block = "172.34.0.0/24"
}

resource "aws_subnet" "subnet1" {
   tags = {
      Name = "Terra-subnet1"
   }
   cidr_block = "172.34.0.0/25"
   vpc_id = "${aws_vpc.myvpc.id}"
}

resource "aws_subnet" "subnet2" {
   tags = {
       Name = "Terraform-subnet2"
   }
   cidr_block = "172.34.0.128/25"
   vpc_id = "${aws_vpc.myvpc.id}"
}

resource "aws_security_group" "mysg" {
   vpc_id = "${aws_vpc.myvpc.id}"
   tags = {
     Name = "Terra-SG"
   }
   ingress {
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]

   }
   egress {
    protocol = "tcp"
    from_port = 0
    to_port = 0
    cidr_blocks = ["0.0.0.0/0"]
   }
}

resource "aws_instance" "myec2" {
  ami = "ami-026b57f3c383c2eec"
  instance_type = "t2.micro"
  subnet_id = "${aws_subnet.subnet1.id}"
  security_groups = ["${aws_security_group.mysg.id}"]
  tags = {
      Name = "My Terra Inst"
  }
  key_name = "1209"
}
