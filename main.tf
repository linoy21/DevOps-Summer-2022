terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}

provider "aws" {
  region = "eu-west-1"
}


resource "aws_vpc" "LinoyMichalashvili-dev-vpc" {

  cidr_block = "10.0.0.0/26"
  tags = {
    "Name" = "LinoyMichalashvili-dev-vpc"
  }

}
resource "aws_subnet" "LinoyMichalashvili-k8s-subnet" {
  vpc_id     = aws_vpc.LinoyMichalashvili-dev-vpc.id
  cidr_block = "10.0.0.0/27"
  tags = {
    "Name" = "LinoyMichalashvili-k8s-subnet"
  }
}

resource "aws_internet_gateway" "LinoyGateway" {
  vpc_id = aws_vpc.LinoyMichalashvili-dev-vpc.id
  tags = {
    Name = "LinoyGateway"
  }
}



resource "aws_route" "routeIGW" {
  route_table_id         = aws_vpc.LinoyMichalashvili-dev-vpc.main_route_table_id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.LinoyGateway.id
}
