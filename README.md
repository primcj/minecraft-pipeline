# Demo Script

---

## Checkpoint 1 — Terraform Apply + Ansible + Server Running

```powershell
terraform apply
```

```powershell
ssh -i C:\Users\jprim\.ssh\cs312-key.pem ubuntu@<new-ip>
```

```bash
sudo apt update && sudo apt install -y ansible awscli
mkdir ~/minecraft-ansible && cd ~/minecraft-ansible
nano playbook.yml
```

```bash
ansible-playbook playbook.yml
```

```bash
sudo usermod -aG docker ubuntu
newgrp docker
docker ps
docker logs minecraft 2>&1 | grep -i "done"
```

---

## Checkpoint 2 — nmap

```powershell
nmap -sV -Pn -p T:25565 <new-ip>
```

---

## Checkpoint 3 — GitHub Actions Pipeline

```
https://github.com/primcj/minecraft-pipeline/actions
```

---

## Checkpoint 4 — Rebuild Proof

```bash
sudo aws s3 sync /opt/minecraft/data s3://minecraft-world-backups-692321740704/world --region us-east-1
```

```powershell
aws ecr batch-delete-image --repository-name minecraft-server --image-ids imageTag=latest
aws ecr batch-delete-image --repository-name minecraft-server --image-ids imageTag=v1.0.2
```

```powershell
terraform destroy
```

```powershell
terraform apply
```

```powershell
ssh -i C:\Users\jprim\.ssh\cs312-key.pem ubuntu@<new-ip>
```

```bash
sudo apt update && sudo apt install -y ansible awscli
mkdir ~/minecraft-ansible && cd ~/minecraft-ansible
nano playbook.yml
```

```bash
ansible-playbook playbook.yml
```

```bash
sudo usermod -aG docker ubuntu
newgrp docker
docker ps
docker logs minecraft 2>&1 | grep -i "done"
```

```powershell
nmap -sV -Pn -p T:25565 <new-ip>
```
