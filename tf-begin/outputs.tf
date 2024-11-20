# output "public_ip" {
#     description = "Public IP of the web server"
#     sensitive = false
#     value = aws_instance.example.public_ip
# }

output "alb_dns_name" {
    description = "DNS name of the load balancer"
    value = aws_lb.example.dns_name
}