provider "aws" {
  region = var.aws_region
}

resource "aws_vpc" "main_vpc" {
  cidr_block           = var.vpc_cidr
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = merge(
    var.common_tags,
    {
      Name = "main-vpc"
    }
  )
}

resource "aws_subnet" "public_subnet_az1" {
  vpc_id                  = aws_vpc.main_vpc.id
  cidr_block              = var.public_subnet_az1_cidr
  availability_zone       = "${var.aws_region}a"
  map_public_ip_on_launch = false

  tags = merge(
    var.common_tags,
    {
      Name = "public-subnet-az1"
      Tier = "public"
      AZ   = "${var.aws_region}a"
    }
  )
}

resource "aws_subnet" "public_subnet_az2" {
  vpc_id                  = aws_vpc.main_vpc.id
  cidr_block              = var.public_subnet_az2_cidr
  availability_zone       = "${var.aws_region}b"
  map_public_ip_on_launch = false

  tags = merge(
    var.common_tags,
    {
      Name = "public-subnet-az2"
      Tier = "public"
      AZ   = "${var.aws_region}b"
    }
  )
}

resource "aws_subnet" "private_app_subnet_az1" {
  vpc_id            = aws_vpc.main_vpc.id
  cidr_block        = var.private_app_subnet_az1_cidr
  availability_zone = "${var.aws_region}a"

  tags = merge(
    var.common_tags,
    {
      Name = "private-app-subnet-az1"
      Tier = "private-app"
      AZ   = "${var.aws_region}a"
    }
  )
}

resource "aws_subnet" "private_app_subnet_az2" {
  vpc_id            = aws_vpc.main_vpc.id
  cidr_block        = var.private_app_subnet_az2_cidr
  availability_zone = "${var.aws_region}b"

  tags = merge(
    var.common_tags,
    {
      Name = "private-app-subnet-az2"
      Tier = "private-app"
      AZ   = "${var.aws_region}b"
    }
  )
}

resource "aws_subnet" "private_db_subnet_az1" {
  vpc_id            = aws_vpc.main_vpc.id
  cidr_block        = var.private_db_subnet_az1_cidr
  availability_zone = "${var.aws_region}a"

  tags = merge(
    var.common_tags,
    {
      Name = "private-db-subnet-az1"
      Tier = "private-db"
      AZ   = "${var.aws_region}a"
    }
  )
}

resource "aws_subnet" "private_db_subnet_az2" {
  vpc_id            = aws_vpc.main_vpc.id
  cidr_block        = var.private_db_subnet_az2_cidr
  availability_zone = "${var.aws_region}b"

  tags = merge(
    var.common_tags,
    {
      Name = "private-db-subnet-az2"
      Tier = "private-db"
      AZ   = "${var.aws_region}b"
    }
  )
}