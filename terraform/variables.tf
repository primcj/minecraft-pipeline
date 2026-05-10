variable "key_name" {
  description = "Name of the existing EC2 key pair"
  type        = string
  default     = "cs312-key"
}

variable "ami_id" {
  description = "Ubuntu 24.04 LTS AMI in us-east-1"
  type        = string
  default     = "ami-0a0e5d9c7acc336f1"
}

variable "instance_type" {
  description = "EC2 instance type for the Minecraft server"
  type        = string
  default     = "t3.medium"
}

variable "minecraft_image_tag" {
  description = "Minecraft image tag to pin in ECR (e.g. java21)"
  type        = string
  default     = "java21"
}

variable "s3_bucket_name" {
  description = "S3 bucket for Minecraft world backups"
  type        = string
  default     = "minecraft-world-backups-692321740704"
}