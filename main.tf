provider "aws" {
    region = " us-east-1"
}

resource "aws_instance" "example" {
    ami =" "
    instance_type = "t2.micro"
    subnet_id = " "
    key_name =" "
}


terraform init 
terraform plan 
terraform apply
terraform destroy