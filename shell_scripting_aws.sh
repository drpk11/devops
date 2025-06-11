#!/bin/bash 

#this script will list all the resources on SAMPLE AWS
#Author : Dharani P
#The following services are listed :
#1.EC2
#2.S3
#3.CLOUDWATCH
#4.LAMBDA
#5.VPC

#USAGE ./shell_sripting_aws.sh <region_name> <service>

aws_region=$1
aws_service=$2

if [$# -ne 2]; then
  echo "usage $0 <region> <service>"
  exit 1
fi

#check aws cli installed
if ! command -v aws &> /dev/null; then
    echo "aws cli not installed"
    exit 1
fi

#check aws configured
if [! -d ~/.aws ]; then
    echo "aws not configured"
    exit 1
fi

#list the resources
case $aws_service in 
    ec2)
        echo "listing ec2 instances"
        aws ec2 describe-instances --region $aws_region
        ;;
    s3)
        echo "listing S3 Buckets"
        aws s3api list-buckets --region $aws_region
        ;;
    cloudwatch)
        echo "listing cloud watch"
        aws cloudwatch describe-alarms --region $aws_region
        ;;
    lambda)
        echo "listing lambda finctions"
        aws lambda list-functions --region $aws_region
        ;;
    vpc)
        echo "listing vpc"
        aws ec2 describe-vpcs --region $aws_region
        ;;
    *)
        echo "invalid service"
        exit 1
        ;;
