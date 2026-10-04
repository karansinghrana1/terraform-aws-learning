output "instance_public_ip" {
    description = "public ip of ec2"
  value = aws_instance.nginx-server.public_ip
}

output "instance_url" {
    description = "url to access nginx"
  value = "http://${aws_instance.nginx-server.public_ip}"
}