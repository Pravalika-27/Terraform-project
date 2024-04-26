provider "aws" {
   region = "${var.region}"
   profile = "default"
}

resource "aws_vpc" "myvpc" {
   tags = {
     Name = "${var.vpcname}"
   }
   cidr_block = "${var.vpccidr}"
}

resource "aws_subnet" "subnet1" {
   tags = {
      Name = "${var.subnet1name}"
   }
   cidr_block = "${var.subnet1cidr}"
   vpc_id = "${aws_vpc.myvpc.id}"
}

resource "aws_subnet" "subnet2" {
   tags = {
       Name = "${var.subnet2name}"
   }
   cidr_block = "${var.subnet2cidr}"
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
  instance_type = "${var.instancetype}"
  subnet_id = "${aws_subnet.subnet1.id}"
  security_groups = ["${aws_security_group.mysg.id}"]
  tags = {
      Name = "My Terra Inst"
  }
  key_name = "${var.keyname}"
}
