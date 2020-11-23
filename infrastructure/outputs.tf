output "api-gateway-private-ip" {
    value = module.api-gateway.private-ip
}

output "api-gateway-public-ip" {
    value = aws_eip.api-gateway-eip.public_ip
}

output "expense-service-private-ip" {
    value = module.expense-service.private-ip
}

output "expense-service-db-address" {
    value = module.expense-service-db.address
}