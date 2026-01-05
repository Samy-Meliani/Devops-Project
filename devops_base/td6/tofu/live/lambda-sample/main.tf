provider "aws" {
    region = "us-east-2"
}
module "function" {
    source = "github.com/Samy-Meliani/devops-base//td3/tofu/modules/lambda"
    name = "lambda-sample" # (1)
    src_dir = "${path.module}/src" # (2)
    runtime = "nodejs20.x" # (3)
    handler = "index.handler" # (4)
    memory_size = 128 # (5)
    timeout = 5 # (6)
    environment_variables = { # (7)
        NODE_ENV = "production"
        name = var.name
    }

    environment_variables = {
        NODE_ENV = "production"
        ENV_NAME = terraform.workspace
        }
}
module "gateway" {
    source = "github.com/your_github_name/devops-base//td3/tofu/modules/api-gateway"
    name = "lambda-sample" # (1)
    function_arn = module.function.function_arn # (2)
    api_gateway_routes = ["GET /"] # (3)
    name = var.name
}