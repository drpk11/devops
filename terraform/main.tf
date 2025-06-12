

provider "aws" {
    region = " us-east-1"
}

/* reference
resource "aws_instance" "example" {
    ami = var.ami_value
    instance_type = var.instance_type_value
    subnet_id = var.subnet_id_value
  
}

resource "aws_s3_bucket" "ex-s3-bucket" {
    bucket = "example-s3-bucket"
}
*/
resource "aws_dynamodb_table" "lock_terraform" {
    name = "lock-terraform"
    billing_mode = "pay"
    hash_key = "lockid"
     
     attribute {
       name = "lockid"
       type = "S"
     }
  
}

variable "instance_type" {
  description = "value"
  type = map(string)
   
   default = {
     "dev" = "t2.micro"
     "stage"= "t2.medium"
     "prod"= "t2.xlarge"
    
   }
}
module "ec2-instance" {
    source = "./modules_main.tf"
    ami = var.ami
    instance_type = lookup(var.instance_type, terraform.workspace , "t2.micro")
    
  
}