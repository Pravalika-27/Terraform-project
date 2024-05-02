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
