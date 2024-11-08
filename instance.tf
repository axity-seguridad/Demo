  # ----------------------------------------------------
# Data Source para obtener el ID de la VPC por defecto
# ----------------------------------------------------
data "aws_vpc" "default" {
  default = true
}

# ---------------------------------------
# Define una instancia EC2 con AMI Ubuntu
# ---------------------------------------
resource "aws_instance" "servidor_demo" {
  ami                     = "ami-0aef57767f5404a3c"
  instance_type           = "t2.micro"
  disable_api_termination = true
  iam_instance_profile = "test"
  monitoring = true
  ebs_optimized = true
  root_block_device {
    encrypted             = true
    delete_on_termination = true
  }
  metadata_options{
    http_endpoint = "enabled"
    http_tokens = "required"
  }
  vpc_security_group_ids  = [aws_security_group.mi_grupo_de_seguridad.id]

  // Escribimos un "here document" que es
  // usado durante la inicialización
  user_data = <<-EOF
              #!/bin/bash
              echo "Hola axity" > index.html
              nohup busybox httpd -f -p 8080 &
              EOF

  tags = {
    Name = "servidor-demo-1"
  }
}

# ------------------------------------------------------
# Define un grupo de seguridad con acceso al puerto 8080
# ------------------------------------------------------
resource "aws_security_group" "mi_grupo_de_seguridad" {
  name   = "servidor-sg"
  vpc_id = data.aws_vpc.default.id
  description = "Security group of instance servidor-1"
  ingress {
    description = "Acceso al puerto 8080 desde el exterior"
    cidr_blocks = ["0.0.0.0/24"]
    from_port   = 8080
    to_port     = 8080
    protocol    = "TCP"
  }
}
