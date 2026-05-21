terraform {
	required_providers {
		aws = {
			source  = "hashicorp/aws"
			version = "~> 4.0"
		}
	}
}

provider "aws" {
	region = var.region
}

data "aws_availability_zones" "available" {}

locals {
	public_subnet_cidrs = [for i in range(var.az_count) : cidrsubnet(var.vpc_cidr, var.public_subnet_newbits, i)]
}

resource "aws_vpc" "main" {
	cidr_block           = var.vpc_cidr
	enable_dns_support   = true
	enable_dns_hostnames = true

	tags = merge(var.tags, { Name = var.name })
}

resource "aws_internet_gateway" "gw" {
	vpc_id = aws_vpc.main.id
	tags   = merge(var.tags, { Name = "${var.name}-igw" })
}

resource "aws_subnet" "public" {
	count                   = var.az_count
	vpc_id                  = aws_vpc.main.id
	cidr_block              = local.public_subnet_cidrs[count.index]
	availability_zone       = data.aws_availability_zones.available.names[count.index]
	map_public_ip_on_launch = true

	tags = merge(var.tags, { Name = "${var.name}-public-${count.index + 1}" })
}

resource "aws_route_table" "public" {
	vpc_id = aws_vpc.main.id

	route {
		cidr_block = "0.0.0.0/0"
		gateway_id = aws_internet_gateway.gw.id
	}

	tags = merge(var.tags, { Name = "${var.name}-public-rt" })
}

resource "aws_route_table_association" "public_assoc" {
	count          = var.az_count
	subnet_id      = aws_subnet.public[count.index].id
	route_table_id = aws_route_table.public.id
}

