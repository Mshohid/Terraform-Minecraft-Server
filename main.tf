provider "aws" {
  region     = "eu-west-2"
  access_key = "aws-access-key"
  secret_key = "aws-secret-access-key" 
}

resource "aws_vpc" "My_VPC" {
    cidr_block = "10.0.0.0/16"

     tags = {
        Name = "Minecraft VPC"
         }
}

resource "aws_internet_gateway" "My_Gateway" {
    vpc_id = aws_vpc.My_VPC.id

    tags = {
        Name = "MC Internet Gateway"
    }
}

resource "aws_route_table" "Routetable" {
    vpc_id = aws_vpc.My_VPC.id

    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.My_Gateway.id
    }
}

resource "aws_subnet" "My_Subnet" {
    vpc_id = aws_vpc.My_VPC.id
    cidr_block = "10.0.1.0/24"
    availability_zone = "eu-west-2a"

    tags = {
        Name = "Mincraft Subnet"
    }
}

resource "aws_route_table_association" "mc" {
    subnet_id = aws_subnet.My_Subnet.id
    route_table_id = aws_route_table.Routetable.id
}

data "http" "myip"{
    url = "https://ipv4.icanhazip.com"
    }

resource "aws_security_group" "Minecraft_sg" {
    name = "Minecraftsecuritygroup"
    description = "Allows SSH and TCP"
    vpc_id = aws_vpc.My_VPC.id

    ingress {
        description = "SSH"
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = ["${chomp(data.http.myip.body)}/32"]
    }

    ingress {
        description = "All TCP"
        from_port = 0
        to_port = 65535
        protocol = "tcp"
        cidr_blocks = ["${chomp(data.http.myip.body)}/32"]
    }

    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
}


resource "aws_instance" "Minecraftserver" {
  ami = "ami-0ffd774e02309201f" 
  instance_type = "t2.micro"
  subnet_id = aws_subnet.My_Subnet.id
  availability_zone = "eu-west-2a"
  associate_public_ip_address = "true"
  key_name = "minecraftserverkey"
  security_groups = [ aws_security_group.Minecraft_sg.id ] 

  # user_data = "${file("userdata.sh")}"
  
  tags = {
        Name = "Minecraft Server"
   }
}