
resource "aws_eip" "api-gateway-eip" {
    instance = module.api-gateway.instance-id

}

module "api-gateway" {
    source      = "./node_server"
    
    ami-id      = "ami-0aef57767f5404a3c" 
    name        = "API Gateway"

    subnet-id   = aws_subnet.expT-public-subnet.id
    vpc-security-group-ids = [
        aws_security_group.allow-http.id,
        aws_security_group.allow-ssh.id,
        aws_security_group.allow-all-outbound.id
    ]
}