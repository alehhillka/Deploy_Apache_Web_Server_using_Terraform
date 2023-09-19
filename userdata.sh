#!/bin/bash
# Сценарій для завантаження index.html з S3 та виконання Ansible Playbook

# Встановлення AWS CLI
sudo yum install -y aws-cli

# Встановлення SSM Agent
sudo yum install -y amazon-ssm-agent

# Запуск SSM Agent
sudo systemctl start amazon-ssm-agent

# Налаштування автозапуску після перезавантаження
sudo systemctl enable amazon-ssm-agent

# Завантаження index.html
aws s3 cp s3://apacheserver/index.html /var/www/html/

# Завантаження Ansible Playbook з S3
aws s3 cp s3://apacheserver/playbook.yml /tmp/playbook.yml

# Встановлення Ansible
sudo amazon-linux-extras install ansible2 -y

# Встановлення firewalld
sudo yum install firewalld -y

# Виконання Ansible Playbook
ansible-playbook /tmp/playbook.yml
