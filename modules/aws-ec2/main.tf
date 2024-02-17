module "vpc" {
  source = "../aws-vpc"
  
}

data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Ubuntu / Canonical owner ID
}

resource "aws_key_pair" "deployer_key" {
  key_name   = "deployer_key"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDH56qGUYgBfAOmkgcN/HEGh2Rc3H04G4qZxUrWbeV5aM2IPPjlN1bU5OHNjGxMPiF9sy2VRpHPj+x8575NC4lLIf1py4ZSBD7LdkeeVFUG3slgOelE2B+ehRL88wB77FFFr/O/SWiKmGxfZieutfia9T8pj8nk+ntfA/hmTBvH3AJ50t8D2eL2MlebCbTWZvsYXJac1szsMI1hBXeE+t94SJdJhcbNyIJUUMGMgTfdVNCl3g1ryIoFQyFt7c5cbCEdcBuVPz7xlOEuGEpFbry33ZxI20p/GuzBvP5JLJyR38xHda3TUhVMx5zjdSppeNq8NrS9SMTVXXxaAsxtA4GN ivan@ivan-Nitro-AN515-54"
}

resource "aws_instance" "web" {
  count                         = 1
  ami                           = data.aws_ami.ubuntu.id
  instance_type                 = "t2.micro"
  key_name                      = aws_key_pair.deployer_key.key_name
  subnet_id                     = module.vpc.subnet_id
  vpc_security_group_ids        = [module.vpc.security_group_id]
  associate_public_ip_address   = true
  user_data = <<-EOF
      #!/bin/bash
      sudo apt-get update
      sudo apt-get install -y openjdk-17-jdk apache2
      
      # Habilitar e iniciar o Apache Web Server
      systemctl enable apache2
      systemctl start apache2
      
      # Verificar se o Java foi instalado corretamente
      java -version

    EOF

  tags = {
    Name = "WebServer-TF-${count.index}"
  }
}