variable "server_port" {
    description = "port to test web server"
    default = 8080
    type = number

    validation {
        condition = var.server_port > 0 && var.server_port < 65536
        error_message = "Port must be between 1 and 65535"
    }

    sensitive = true
}