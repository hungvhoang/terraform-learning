output "public_ip" {
    description = "Public IP of the web server"
    sensitive = false
    value = aws_instance.example.public_ip
}