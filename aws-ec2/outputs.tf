output "aws_instance_public_ip" {
  value = aws_instance.terraform-server-02.public_ip
}