terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}

# ── Networking ────────────────────────────────────────────────────────────────

resource "aws_vpc" "minecraft" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_hostnames = true
  tags = { Name = "minecraft-vpc" }
}

resource "aws_subnet" "minecraft_public" {
  vpc_id                  = aws_vpc.minecraft.id
  cidr_block              = "10.0.1.0/24"
  availability_zone       = "us-east-1a"
  map_public_ip_on_launch = true
  tags = { Name = "minecraft-public-subnet" }
}

resource "aws_internet_gateway" "minecraft_igw" {
  vpc_id = aws_vpc.minecraft.id
  tags   = { Name = "minecraft-igw" }
}

resource "aws_route_table" "minecraft_public_rt" {
  vpc_id = aws_vpc.minecraft.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.minecraft_igw.id
  }
  tags = { Name = "minecraft-public-rt" }
}

resource "aws_route_table_association" "minecraft_public_rta" {
  subnet_id      = aws_subnet.minecraft_public.id
  route_table_id = aws_route_table.minecraft_public_rt.id
}

# ── Security Group ────────────────────────────────────────────────────────────

resource "aws_security_group" "minecraft" {
  name        = "minecraft-sg"
  description = "SSH admin access and Minecraft client access"
  vpc_id      = aws_vpc.minecraft.id

  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Minecraft"
    from_port   = 25565
    to_port     = 25565
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = { Name = "minecraft-sg" }
}

# ── EC2 Instance ──────────────────────────────────────────────────────────────

resource "aws_instance" "minecraft" {
  ami                    = var.ami_id
  instance_type          = var.instance_type
  key_name               = var.key_name
  subnet_id              = aws_subnet.minecraft_public.id
  vpc_security_group_ids = [aws_security_group.minecraft.id]
  iam_instance_profile   = "LabInstanceProfile"

  root_block_device {
    volume_size = 20
    volume_type = "gp3"
  }

  tags = { Name = "minecraft-server" }
}

# ── S3 Bucket for world backups ───────────────────────────────────────────────

resource "aws_s3_bucket" "minecraft_world" {
  bucket        = var.s3_bucket_name
  force_destroy = true

  lifecycle {
    prevent_destroy = true
  }
}

resource "aws_s3_bucket_versioning" "minecraft_world" {
  bucket = aws_s3_bucket.minecraft_world.id
  versioning_configuration {
    status = "Enabled"
  }
}

# ── ECR Repository ────────────────────────────────────────────────────────────

resource "aws_ecr_repository" "minecraft" {
  name                 = "minecraft-server"
  image_tag_mutability = "MUTABLE"
  force_delete         = true
  image_scanning_configuration {
    scan_on_push = false
  }
  tags = { Name = "minecraft-ecr" }
}
