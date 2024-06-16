provider "aws" {
        region = "us-east-1"
        profile = "nimesh-tf"
}

resource "aws_security_group" "sg-1" {
    name = "devops_sg"
    description = "allow SSH"
    vpc_id = "vpc-0878576bf5014e561"

ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
}
egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
}
}

resource "aws_instance" "vm" {
    ami = "ami-08a0d1e16fc3f61ea"
    instance_type = "t2.micro"
    key_name = "dev"
    availability_zone = "us-east-1a"
    vpc_security_group_ids = [aws_security_group.sg-1.id]
    tags = {
        name = "hello"
    }
}
