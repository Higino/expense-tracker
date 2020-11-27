output "instance-id" {
    value = aws_instance.ec2-node-server.id
}

output "name" {
    value = var.name
}

output "private-ip" {
    value = aws_instance.ec2-node-server.private_ip
}

