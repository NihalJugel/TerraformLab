resource "aws_instance" "web" {
  ami                    = var.amiID[var.region]
  instance_type          = "t3.micro"
  key_name               = "dove-key"
  security_groups        = [aws_security_group.dove-sg.name]
  vpc_security_group_ids = [aws_security_group.dove-sg.id]
  availability_zone      = var.zone1

  tags = {
    Name    = "dove-web"
    Project = "Dove"
  }

  provisioner "file" {
    source      = "web.sh"
    destination = "/tmp/web.sh"
  }

  connection {
    type        = "ssh"
    user        = var.webuser
    private_key = file("dovekey")
    host        = self.public_ip
  }

  provisioner "remote-exec" {
    inline = [
      "chmod +x /tmp/web.sh",
      "sudo /tmp/web.sh"
    ]
  }
  provisioner "local-exec" {
    command = "echo 'Web instance ${self.private_ip} created successfully' >> private_ip.txt"
  }
}

resource "aws_ec2_instance_state" "web-state" {
  instance_id = aws_instance.web.id
  state       = "running"
}

output "WebPublicIP" {
  description = "Public ip of instanvce"
  value       = aws_instance.web.public_ip
}

output "WebPrivateIP" {
  description = "Private ip of web instance"
  value       = aws_instance.web.private_ip
}



