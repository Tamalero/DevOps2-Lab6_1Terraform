# Compute Instances

# Create two EC2 instances
resource "aws_instance" "jenkinscontroller" {
  ami             = "ami-0440d3b780d96b29d" # Amazon Linux 2 AMI (HVM)
  instance_type   = "t2.micro"
  subnet_id       = aws_subnet.main_a.id
  security_groups = [aws_security_group.jenkins_sg.id]
  key_name        = aws_key_pair.generated_key.key_name
  tags = {
    Name = "JenkinsController"
  }
  root_block_device {
    volume_size = 30  # Set the size of the root volume in GB
  }
  user_data = file("scripts/jenkins-script.sh")
}

resource "aws_instance" "jenkinsagent" {
  ami             = "ami-0440d3b780d96b29d" # Amazon Linux 2 AMI (HVM)
  instance_type   = "t2.micro"
  subnet_id       = aws_subnet.main_a.id
  security_groups = [aws_security_group.jenkins_sg.id]
  key_name        = aws_key_pair.generated_key.key_name
  tags = {
    Name = "JenkinsPermaAgent"
  }
  root_block_device {
    volume_size = 30  # Set the size of the root volume in GB
  }
  user_data = file("scripts/jenkins-script.sh")
}

# Testing and Staging

resource "aws_instance" "Testing" {
  ami             = "ami-0440d3b780d96b29d" # Amazon Linux 2 AMI (HVM)
  instance_type   = "t2.micro"
  subnet_id       = aws_subnet.main_a.id
  security_groups = [aws_security_group.jenkins_sg.id]
  key_name        = aws_key_pair.generated_key.key_name
  tags = {
    Name = "Testing"
  }
  root_block_device {
    volume_size = 30  # Set the size of the root volume in GB
  }
  user_data = file("scripts/apache-script.sh")
}

resource "aws_instance" "Staging" {
  ami             = "ami-0440d3b780d96b29d" # Amazon Linux 2 AMI (HVM)
  instance_type   = "t2.micro"
  subnet_id       = aws_subnet.main_a.id
  security_groups = [aws_security_group.jenkins_sg.id]
  key_name        = aws_key_pair.generated_key.key_name
  tags = {
    Name = "Staging"
  }
  root_block_device {
    volume_size = 30  # Set the size of the root volume in GB
  }
  user_data = file("scripts/apache-script.sh")
}

# Web servers for production

resource "aws_instance" "production_environment_1" {
  ami             = "ami-0440d3b780d96b29d" # Amazon Linux 2 AMI (HVM)
  instance_type   = "t2.micro"
  subnet_id       = aws_subnet.main_b.id
  security_groups = [aws_security_group.web_sg.id]
  key_name        = aws_key_pair.generated_key.key_name
  tags = {
    Name = "ProductionEnvironment1"
  }
  root_block_device {
    volume_size = 30  # Set the size of the root volume in GB
  }
  user_data = file("scripts/apache-script.sh")
}

resource "aws_instance" "production_environment_2" {
  ami             = "ami-0440d3b780d96b29d" # Amazon Linux 2 AMI (HVM)
  instance_type   = "t2.micro"
  subnet_id       = aws_subnet.main_c.id
  security_groups = [aws_security_group.web_sg.id]
  key_name        = aws_key_pair.generated_key.key_name
  tags = {
    Name = "ProductionEnvironment2"
  }
  root_block_device {
    volume_size = 30  # Set the size of the root volume in GB
  }
  user_data = file("scripts/apache-script.sh")
}
