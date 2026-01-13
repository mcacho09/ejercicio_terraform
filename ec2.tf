
# 2. Security group (allow HTTP + SSH)
resource "aws_security_group" "nodejs_sg" {
  name        = "nodejs-sg"
  description = "Allow HTTP and SSH"

  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# 3. EC2 instance with user-data to install Node.js
resource "aws_instance" "nodejs_app" {
  ami             = "ami-0c55b159cbfafe1f0" # Amazon Linux 2 AMI (update per region)
  instance_type   = "t2.micro"
  key_name        = aws_key_pair.deployer.key_name
  security_groups = [aws_security_group.nodejs_sg.name]

  user_data = <<-EOF
              #!/bin/bash
              yum update -y
              curl -sL https://rpm.nodesource.com/setup_18.x | bash -
              yum install -y nodejs git
              cd /home/ec2-user
              git clone https://github.com/your/repo.git app
              cd app
              npm install
              npm install -g pm2
              pm2 start app.js
              pm2 startup
              pm2 save
              EOF
  tags = merge(
    var.common_tags,
    {
      Name = "NodeJS-App-Server"
    }
  )

}
