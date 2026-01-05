# td6/tofu/live/child-accounts/main.tf (Example 6-1)
provider "aws" {
    region = "us-east-2" # Or your preferred region
}
module "child_accounts" {
    source = "github.com/Samy-Meliani/Devops6-Project/devops-base//td6/tofu/modules/awsorganization"
    create_organization = true # Set to false if you already enabled AWS Organizations
    dev_account_email = "samymeliani24+dev@gmail.com" # Replace with your email alias
    stage_account_email = "samymeliani24+stage@gmail.com" # Replace with your email alias
    prod_account_email = "samymeliani24+prod@gmail.com" # Replace with your email alias
}
