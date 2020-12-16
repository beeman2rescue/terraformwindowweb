provider "aws" {
  region     = "us-east-2"
  access_key = ""
  secret_key = ""
}

resource "aws_vpc" "firstvpc" {
  cidr_block = "10.0.0.0/16"
  tags = {
    "Name" = "production"
  }
}

resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.firstvpc.id

}

resource "aws_route_table" "production" {
  vpc_id = aws_vpc.firstvpc.id

    route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }

route {
    ipv6_cidr_block        = "::/0"
    gateway_id = aws_internet_gateway.gw.id
  }
  tags = {
    Name = "prod"
  }
}

resource "aws_subnet" "subnet2" {
  vpc_id = aws_vpc.firstvpc.id
  cidr_block = "10.0.50.0/24"
  availability_zone = "us-east-2a"
    
}

resource "aws_subnet" "subnet1" {
  vpc_id = aws_vpc.firstvpc.id
  cidr_block = "10.0.1.0/28"
  availability_zone = "us-east-2a"

  tags = {
    Name = "prodsubnet"
    }
  }

  resource "aws_route_table_association" "a" {
  subnet_id      = aws_subnet.subnet1.id
  route_table_id = aws_route_table.production.id
}

resource "aws_security_group" "allow_web" {
  name        = "allow_web"
  description = "Allow web inbound traffic"
  vpc_id      = aws_vpc.firstvpc.id

  ingress {
    description = "HTTPS"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
ingress {
    description = "HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
}


ingress {
    description = "ssh"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
}
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
resource "aws_instance" "websvr1" {
  ami = "ami-0d5b55fd8cd8738f5"
  instance_type = "t2.micro"
  availability_zone = "us-east-2a"
  
  key_name = "ohio-key"
}

resource "aws_instance" "websvr3" {
  ami = "ami-0d5b55fd8cd8738f5"
  instance_type = "t2.micro"
  availability_zone = "us-east-2a"  
  
  key_name = "ohio-key"
  
}

resource "aws_instance" "websvr5" {
  ami = "ami-0d5b55fd8cd8738f5"
  instance_type = "t2.micro"
  availability_zone = "us-east-2a"
  
  key_name = "ohio-key"
  
}

resource "aws_instance" "websvr6" {
  ami = "ami-0d5b55fd8cd8738f5"
  instance_type = "t2.micro"
  availability_zone = "us-east-2a"
    key_name = "ohio-key"
   

}
