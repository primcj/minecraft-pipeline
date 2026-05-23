output "minecraft_public_ip" {
  description = "Public IP of the Minecraft server — use this for SSH and nmap"
  value       = aws_instance.minecraft.public_ip
}

output "ecr_repository_url" {
  description = "ECR URL — needed for the GitHub Actions pipeline and Ansible"
  value       = aws_ecr_repository.minecraft.repository_url
}
