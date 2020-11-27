variable "aws_profile" {
    default = "dev_ops"
    type = string
}

variable "aws_region" {
    default = "eu-west-1"
    type = string
}

variable "expense-service-db-password" {
    type = string
}

variable "expense-service-db-username" {
    type = string
}