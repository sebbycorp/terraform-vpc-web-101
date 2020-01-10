## Building stuff With Terraform

The following repo builds:
1. Single VPC with 3 Availabiliry Zones
2. Deploys 3 Nginx Web Servers
3. Deploys 3 Consul Servers

How to start:
1. Download and install terraform on you computer https://learn.hashicorp.com/terraform/getting-started/install.html
2. download this git to you computer
3. Download AWS CLI and set it up
4. Setup you AWS IAM Access

AmazonEC2FullAccess: required for this blog post.
AmazonS3FullAccess: required for How to manage Terraform state.
AmazonDynamoDBFullAccess: required for How to manage Terraform state.
AmazonRDSFullAccess: required for How to create reusable infrastructure with Terraform modules.
CloudWatchFullAccess: required for Terraform tips & tricks: loops, if-statements, and pitfalls.
IAMFullAccess: required for Terraform tips & tricks: loops, if-statements, and pitfalls.

4. Configure your AWS credentials #aws configure
5. In order for Terraform to be able to make changes in your AWS account, you will need to configure the AWS credentials for the user you created earlier. There are several ways to do this (see A Comprehensive Guide to Authenticating to AWS on the Command Line), one of the easiest of which is to set the following environment variables:

```
export AWS_ACCESS_KEY_ID=(your access key id)
export AWS_SECRET_ACCESS_KEY=(your secret access key)
```

6. Run the terraform commands
```
terraform init
terraform plan 
terraform apply
```

Enjoy
