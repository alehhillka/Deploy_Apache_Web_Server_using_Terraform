resource "aws_instance" "apache" {
  ami           = "ami-06fd5f7cfe0604468" 
  instance_type = "t2.micro"
  vpc_security_group_ids = [aws_security_group.lb_sg.id]
  subnet_id = aws_subnet.public-subnet-1.id
  key_name      = "ssh" 
  user_data     = base64encode(file("userdata.sh"))
  associate_public_ip_address = true
  iam_instance_profile = aws_iam_instance_profile.apache_profile.name
    
  tags = {
    "Name" = "apache_1"
  }
}
