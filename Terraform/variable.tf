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
