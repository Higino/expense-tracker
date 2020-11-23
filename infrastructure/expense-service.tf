
resource "aws_eip" "expense-service-eip" {
    instance = module.api-gateway.instance-id

}

module "expense-service" {
    source      = "./node_server"
    
    ami-id      = "ami-0aef57767f5404a3c" 
    name        = "Expense service"

    #TODO: Change the expense service to a private subnet so its not expose to the public
    subnet-id   = aws_subnet.expT-public-subnet.id
    private-ip  = "10.0.0.5" # Must be within the rang4e of the public cidr-block of the public subnet
 
    vpc-security-group-ids = [
        aws_security_group.allow-http.id,
        aws_security_group.allow-ssh.id,
        aws_security_group.allow-all-outbound.id
    ]
}

module "expense-service-db" {
    source = "./postgres_db"

    apply-immediately      = true
    db-name                = "expense_db"
    db-subnet-group-name   = aws_db_subnet_group.private-db-subnet-group.id
    identifier             = "expense-service-db"
    username               = var.expense-service-db-username
    password               = var.expense-service-db-password
    publicly-accessible    = false
    vpc-security-group-ids = [aws_security_group.allow-internal-postgres.id]    
}

/*
module "expense-service-codedeploy" {
  source = "./codedeploy-app"

  app-name          = "expense-service"
  ec2-instance-name = module.expense-service.name
}
*/