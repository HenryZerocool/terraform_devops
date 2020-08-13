# Specify the provider and access details
provider "aws" {
  region     = "ca-central-1"
  access_key = var.aws_access_key
  secret_key = var.aws_secret_key
}
resource "aws_instance" "jenkins-server" {
  ami             = "ami-0cb4ab005c0b6e1fe"
  instance_type   = "t2.micro"
  private_ip      = "172.31.10.222"
  security_groups = ["devopsz"]
  availability_zone = "ca-central-1b"
  tags = {
    Name = "Jenkins Server"
  }
}
resource "aws_instance" "nexus-server" {
  ami             = "ami-0172946220997be95"
  instance_type   = "t2.micro"
  private_ip      = "172.31.29.188"
  security_groups = ["devopsz"]
  availability_zone = "ca-central-1a"
  tags = {
    Name = "Nexus Server"
  }
}
resource "aws_instance" "ansible-server" {
  ami             = "ami-0ab45f63088cb1508"
  instance_type   = "t2.micro"
  private_ip      = "172.31.11.234"
  security_groups = ["devopsz"]
  availability_zone = "ca-central-1b"
  tags = {
    Name = "Ansible Server"
  }
}
resource "aws_instance" "tomcat-server" {
  ami             = "ami-03b559ce3dcb191dd"
  instance_type   = "t2.micro"
  private_ip      = "172.31.12.44"
  security_groups = ["devopsz"]
  availability_zone = "ca-central-1b"
  tags = {
    Name = "Tomcat Server"
  }
}

# resource "aws_vpc" "default" {
#     cidr_block = var.vpc_cidr
#     enable_dns_hostnames = true
#     // tags {
#     //     Name = "terraform-aws-vpc"
#     // }
# }

# resource "aws_internet_gateway" "default" {
#     vpc_id = aws_vpc.default.id
# }

# /*
#   NAT Instance
# */
# resource "aws_security_group" "nat" {
#     name = "vpc_nat"
#     description = "Allow traffic to pass from the private subnet to the internet"

#     ingress {
#         from_port = 80
#         to_port = 80
#         protocol = "tcp"
#         cidr_blocks = [var.private_subnet_cidr]
#     }
#     ingress {
#         from_port = 443
#         to_port = 443
#         protocol = "tcp"
#         cidr_blocks = [var.private_subnet_cidr]
#     }
#     ingress {
#         from_port = 22
#         to_port = 22
#         protocol = "tcp"
#         cidr_blocks = ["0.0.0.0/0"]
#     }
#     ingress {
#         from_port = -1
#         to_port = -1
#         protocol = "icmp"
#         cidr_blocks = ["0.0.0.0/0"]
#     }

#     egress {
#         from_port = 80
#         to_port = 80
#         protocol = "tcp"
#         cidr_blocks = ["0.0.0.0/0"]
#     }
#     egress {
#         from_port = 443
#         to_port = 443
#         protocol = "tcp"
#         cidr_blocks = ["0.0.0.0/0"]
#     }
#     egress {
#         from_port = 22
#         to_port = 22
#         protocol = "tcp"
#         cidr_blocks = [var.vpc_cidr]
#     }
#     egress {
#         from_port = -1
#         to_port = -1
#         protocol = "icmp"
#         cidr_blocks = ["0.0.0.0/0"]
#     }

#     vpc_id = aws_vpc.default.id

#     // tags {
#     //     Name = "NATSG"
#     // }
# }

# resource "aws_instance" "nat" {
#     ami = "ami-056ee704806822732" # this is a special ami preconfigured to do NAT
#     availability_zone = "us-west-1b"
#     instance_type = "m1.small"
#     key_name = var.aws_key_name
#     vpc_security_group_ids = [aws_security_group.nat.id]
#     subnet_id = aws_subnet.us-west-1b-public.id
#     associate_public_ip_address = true
#     source_dest_check = false

#     // tags {
#     //     Name = "VPC NAT"
#     // }
# }

# resource "aws_eip" "nat" {
#     instance = aws_instance.nat.id
#     vpc = true
# }

# /*
#   Public Subnet
# */
# resource "aws_subnet" "us-west-1b-public" {
#     vpc_id = aws_vpc.default.id

#     cidr_block = var.public_subnet_cidr
#     availability_zone = "us-west-1b"

#     // tags {
#     //     Name = "Public Subnet"
#     // }
# }

# resource "aws_route_table" "us-west-1b-public" {
#     vpc_id = aws_vpc.default.id

#     route {
#         cidr_block = "0.0.0.0/0"
#         gateway_id = aws_internet_gateway.default.id
#     }

#     // tags {
#     //     Name = "Public Subnet"
#     // }
# }

# resource "aws_route_table_association" "us-west-1b-public" {
#     subnet_id = aws_subnet.us-west-1b-public.id
#     route_table_id = aws_route_table.us-west-1b-public.id
# }

# /*
#   Private Subnet
# */
# resource "aws_subnet" "us-west-1b-private" {
#     vpc_id = aws_vpc.default.id

#     cidr_block = var.private_subnet_cidr
#     availability_zone = "us-west-1b"

#     // tags {
#     //     Name = "Private Subnet"
#     // }
# }

# resource "aws_route_table" "us-west-1b-private" {
#     vpc_id = aws_vpc.default.id

#     route {
#         cidr_block = "0.0.0.0/0"
#         instance_id = aws_instance.nat.id
#     }

#     // tags {
#     //     Name = "Private Subnet"
#     // }
# }

# resource "aws_route_table_association" "us-west-1b-private" {
#     subnet_id = aws_subnet.us-west-1b-private.id
#     route_table_id = aws_route_table.us-west-1b-private.id
# }
