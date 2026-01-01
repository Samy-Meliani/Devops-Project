provider "aws" {
  region = "us-east-2"
}

module "oidc_provider" {
  source       = "github.com/Samy-Meliani/devopsbase//td5/scripts/tofu/modules/github-aws-oidc"
  provider_url = "https://token.actions.githubusercontent.com"
}

module "gh_actions_roles" {
  source = "github.com/Samy-Meliani/devopsbase//td5/scripts/tofu/modules/gh-actions-iam-roles"

  repository = "Samy-Meliani/devopsbase"

  roles = {
    deploy = {
      policy_arns = [
        "arn:aws:iam::aws:policy/AdministratorAccess"
      ]
    }

    test = {
      policy_arns = [
        "arn:aws:iam::aws:policy/ReadOnlyAccess"
      ]
    }
  }
}

resource "aws_dynamodb_table" "tofu_lock" {
  name         = "tofu-state-lock"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }
}

module "iam_roles" {
source = "github.com/Samy-Meliani/devopsbase//td5/scripts/tofu/modules/gh-actions-iam-roles"
name = "lambda-sample"
oidc_provider_arn = module.oidc_provider.oidc_provider_arn
enable_iam_role_for_testing = true
enable_iam_role_for_plan = true # Add for plan role
enable_iam_role_for_apply = true # Add for apply role

github_repo = "Samy-Meliani/Devops-Project"
lambda_base_name = "lambda-sample"
tofu_state_bucket = "devops-admin" 
tofu_state_dynamodb_table = "tofu-state-lock"
}

