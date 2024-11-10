provider "aws" {
    region = "ap-southeast-1" 
}

data "aws_vpc" "default" {
    default = true
}

data "aws_subnets" "default" {
    filter {
        name = "vpc-id"
        values = [data.aws_vpc.default.id]
    }
}

resource "aws_launch_configuration" "example" {
    image_id = "ami-047126e50991d067b"
    instance_type = "t2.micro"
    security_groups = [aws_security_group.instance.name]
    user_data = <<-EOF
                #!/bin/bash
                echo "Hello, World" > index.html
                nohup busybox httpd -f -p ${var.server_port} &
                EOF

    // required if using autoscaling group
    lifecycle {
        create_before_destroy = true
    }
}

resource "aws_autoscaling_group" "example" {
    launch_configuration = aws_launch_configuration.example.name
    vpc_zone_identifier = data.aws_subnets.default.ids

    min_size = 2
    max_size = 5

    tag {
        key = "Name"
        value = "Ubuntu1"
        propagate_at_launch = true
    }
}


# resource "aws_instance" "example" {
#     ami = "ami-047126e50991d067b"
#     instance_type = "t2.micro"

#     vpc_security_group_ids = [aws_security_group.instance.id]

#     user_data = <<-EOF
#                 #!/bin/bash
#                 echo "Hello, World" > index.html
#                 nohup busybox httpd -f -p ${var.server_port} &
#                 EOF

#     user_data_replace_on_change = true

#     tags = {
#         Name = "Ubuntu1"
#     }
# }

resource "aws_security_group" "instance" {
    name = "web"

    ingress {
        from_port = var.server_port 
        to_port = var.server_port
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    } 
}