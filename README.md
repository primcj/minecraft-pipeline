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
vim playbook.yml
```

```bash
ansible-playbook playbook.yml
```

```bash
sudo docker ps
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

## Before Checkpoint 4 — Back Up World to S3
# Still SSH'd into the server from Checkpoint 1

```bash
sudo aws s3 sync /opt/minecraft/data s3://minecraft-world-backups-692321740704/world --region us-east-1
```

```bash
aws s3 ls s3://minecraft-world-backups-692321740704/world/world/ --region us-east-1
```

---

## Checkpoint 4 — Rebuild Proof

```powershell
aws ecr batch-delete-image --repository-name minecraft-server --image-ids imageTag=latest
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
vim playbook.yml
```

```bash
ansible-playbook playbook.yml
```

```bash
sudo docker ps
```

```powershell
nmap -sV -Pn -p T:25565 <new-ip>
```
