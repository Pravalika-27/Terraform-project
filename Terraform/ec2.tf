provider "aws"{
  region ="ap-south-1"
  profile="default"
}

resource "aws_vpc""myvpc"{
  cidr_block="172.35.0.0/24"
  tags={
    Name="Terra-vpc"
   }
}

resource "aws_subnet""subnetA"{
  vpc_id=aws_vpc.myvpc.id
  cidr_block="172.35.0.0/25"
  tags={
    Name="Terra-vpc-sa"
  }
}

resource "aws_subnet""subnetB"{
  vpc_id=aws_vpc.myvpc.id
  cidr_block="172.35.0.128/25"
  tags={
    Name="Terra-vpc-sb"
  }
}

resource "aws_security_group""mysg"{
  vpc_id=aws_vpc.myvpc.id
  tags={
    Name="Terra-sg"
  }
  ingress{
    protocol="tcp"
    from_port=22
    to_port=22
    cidr_blocks=["0.0.0.0/0"]
  }
  egress{
    protocol="tcp"
    cidr_blocks=["0.0.0.0/0"]
    from_port=0
    to_port=0
  }
}

resource "aws_instance""myec2"{
  ami="ami-001843b876406202a"
  instance_type="t2.micro"
  subnet_id=aws_subnet.subnetA.id
  tags={
    Name="Terra-Ec2"
  }
  security_groups=[aws_security_group.mysg.id]
  key_name="K8"
}

resource "aws_s3_bucket" "example" {
  bucket = "my-tf-intercareer-bucket"
  tags = {
    Name        = "My bucket"
    Environment = "Dev"
  }
}



