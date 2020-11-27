resource "aws_instance" "ec2-node-server"{
    ami                     = var.ami-id
    iam_instance_profile    = var.iam-instance-profile
    instance_type            = var.instance-type
    private_ip              = var.private-ip
    subnet_id               = var.subnet-id
    vpc_security_group_ids  = var.vpc-security-group-ids
    
    tags = {
        Name = var.name
    }
    
    user_data = <<-EOF
#!/bin/bash
sudo apt update -y
sudo apt install docker.io docker docker-compose apache2 npm ruby -y
wget https://aws-codedeploy-eu-west-1.s3.eu-west-1.amazonaws.com/latest/install
chmod +x ./install
sudo ./install auto > /tmp/logfile
sudo systemctl start apache2
sudo bash -c 'docker -v > /var/www/html/index.html'
EOF

}
