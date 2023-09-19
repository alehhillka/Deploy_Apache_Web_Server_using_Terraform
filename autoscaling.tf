provider "aws" {
  region = "eu-central-1" 
}


# Створення Launch Template
resource "aws_launch_template" "apache" {
  name_prefix   = "apache-lt"
  image_id      = "ami-06fd5f7cfe0604468" 
  instance_type = "t2.micro"
  user_data = base64encode(
  <<-EOF
#!/bin/bash
sudo yum install -y aws-cli
sudo yum install -y amazon-ssm-agent
sudo systemctl start amazon-ssm-agent
sudo systemctl enable amazon-ssm-agent
aws s3 cp s3://apacheserver/index.html /var/www/html/
aws s3 cp s3://apacheserver/playbook.yml /tmp/playbook.yml
sudo amazon-linux-extras install ansible2 -y
sudo yum install firewalld -y
ansible-playbook /tmp/playbook.yml

echo '[Settings]
aws_region = eu-central-1
[AmazonCloudWatchLogs]
region = eu-central-1
log_group_name = /var/log/amazon/ssm/amazon-ssm-agent.log' | sudo tee -a /etc/amazon/ssm/amazon-ssm-agent.json
  EOF
)
  vpc_security_group_ids = [aws_security_group.lb_sg.id]
  key_name = "ssh"
  iam_instance_profile {
    name = aws_iam_instance_profile.apache_profile.name
  }

}

# Створення Auto Scaling Group (ASG)
resource "aws_autoscaling_group" "apache" {
  name             = "apache-asg"
  min_size         = 1
  max_size         = 1
  desired_capacity = 1
  
  launch_template {
    id      = aws_launch_template.apache.id
    version = aws_launch_template.apache.latest_version
  }
  
  vpc_zone_identifier = [aws_subnet.private-subnet.id]  # Приватна підмережа, де буде розміщено екземпляри
  health_check_type  = "EC2"
}

# Створення Security Group для Auto Scaling Group
resource "aws_security_group" "asg_security_group" {
  name_prefix = "asg-"
  description = "Security Group for Auto Scaling Group"
  vpc_id = aws_vpc.vpc.id  # Встановіть відповідну ідентифікаційну інформацію про вашу VPC
}



