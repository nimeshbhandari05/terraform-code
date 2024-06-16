provider "aws" {
        region = "us-east-1"
        profile = "devops.tf"
} 

resource "aws_security_group" "sg-1" {
    name = "devops_sg"
    description = "allow SSH"
    vpc_id = "vpc-0878576bf5014e561"

ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_block = "0.0.0.0/0"
}
egress {
    from_port = 0
    to_port = 0 
    protocol = "-1"
    cidr_block = "0.0.0.0/0"
}
}

resource "aws_instance" "vm-1" {
    ami = "ami-0e326862c8e74c0fe"
    instance_type "t2.micro"
    key_name = "batch34"
    availability_zone = "us-east-1a"
    vpc_security_group_ids = [aws_security_group.sg-1.id]
    tags = {
        name = "hello"
    }
}

