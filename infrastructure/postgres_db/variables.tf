variable "apply-immediately" {
    default     = false
    type        = bool
}

variable "db-name" {
    type    = string
}

variable "db-subnet-group-name" {
    type    = string
}


variable "identifier" {
    type    = string
}

variable "instance-class" {
    default = "db.t2.micro"
    type    = string
}

variable "engine-version" {
    default = "12.3"
    type    = string
}

variable "engine" {
    default = "postgres"
    type    = string 
}

variable "parameter-group-name" {
    default = "default.postgres12"
    type    = string
}

variable "publicly-accessible" {
    type    = bool
}

variable "password" {
    type    = string
}

variable "username" {
    type = string
}

variable "vpc-security-group-ids" {
    default = []
    type    = list(string)
}