resource "aws_vpc" "terraform-vpc" {
    cidr_block = "10.12.0.0/16"
    enable_classiclink = "false"
    instance_tenancy = "default"    
    
    tags = {
        Name = "terraform-vpc"
    }
}

resource "aws_subnet" "terraform-subnet-public-1" {
    vpc_id = aws_vpc.terraform-vpc.id
    cidr_block = "10.12.1.0/24"
    map_public_ip_on_launch = "true"
    availability_zone = "${var.AWS_REGION}a"
    tags = {
        Name = "terraform-subnet-public-1"
    }
}

resource "aws_internet_gateway" "terraform-igw" {
    vpc_id = aws_vpc.terraform-vpc.id
    tags = {
        Name = "terraform-igw"
    }
}

resource "aws_route_table" "terraform-public-crt" {
    vpc_id = aws_vpc.terraform-vpc.id
    
    route {
        cidr_block = "0.0.0.0/0" 
        gateway_id = aws_internet_gateway.terraform-igw.id
    }
    
    tags = {
        Name = "terraform-public-crt"
    }
}

resource "aws_route_table_association" "terraform-crt-public-subnet-1"{
    subnet_id = aws_subnet.terraform-subnet-public-1.id
    route_table_id = aws_route_table.terraform-public-crt.id
}

# Security groups

resource "aws_security_group" "ssh-http-allowed" {
    vpc_id = aws_vpc.terraform-vpc.id
    
    egress {
        from_port = 0
        to_port = 0
        protocol = -1
        cidr_blocks = ["0.0.0.0/0"]
    }
    ingress {
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    ingress {
        from_port = 80
        to_port = 80
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    tags = {
        Name = "ssh-http-allowed"
    }
}