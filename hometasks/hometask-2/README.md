# Create EC2 instance with Terraform

 - Instance Parameters:
    - Instance type : t2.micro
    - AMI: select ami id for Amazon Linux 2023 for your region
    - tag: Key=Name; value=my-terraform-webserver
- Your instance should install, enable httpd and put the following in index.html file:
<html><body><h1>Session-2 homework is complete! </h1></body></html>

# Hint: use user_data argument 

Reading:
What is terraform.tfstate?
What is backend?
What is local and remote backend?