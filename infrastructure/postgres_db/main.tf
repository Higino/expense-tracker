resource "aws_db_instance" "default" {
    allocated_storage       = 20
    storage_type            = "gp2"
    engine                  = var.engine
    engine_version          = var.engine-version
    apply_immediately       = var.apply-immediately
    db_subnet_group_name    = var.db-subnet-group-name
    identifier              = var.identifier
    instance_class          = var.instance-class
    name                    = var.db-name
    parameter_group_name    = var.parameter-group-name
    password                = var.password
    publicly_accessible     = var.publicly-accessible
    skip_final_snapshot     = true
    username                = var.username
    vpc_security_group_ids  = var.vpc-security-group-ids
}