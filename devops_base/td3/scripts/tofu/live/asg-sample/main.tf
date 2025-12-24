provider "aws" {
region = "us-east-2"
}
module "alb" {
source = "github.com/Samy-Meliani/Devops-Project/devops-base/td3/scripts/tofu/modules/alb"
name = "sample-app-alb"
alb_http_port = 80
app_http_port = 8080
app_health_check_path = "/"
}
module "asg" {
source = "github.com/Samy-Meliani/Devops-Project/devops_base/td3/scripts/tofu/modules/asg"
name = "sample-app-asg"
ami_id = "256177"
user_data = filebase64("${path.module}/user-data.sh")
app_http_port = 8080
instance_type = "t2.micro"
min_size = 1
max_size = 10
desired_capacity = 3
target_group_arns = [module.alb.target_group_arn]

instance_refresh = {
min_healthy_percentage = 100
max_batch_size = 1
strategy = "Rolling"
auto_rollback = true
}

}

