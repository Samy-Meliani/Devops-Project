provider "aws" {
region = "us-east-2"
}
module "cluster" {
source = "github.com/your_github_name/devops-base//td3/tofu/modules/eks-cluster"
name = "eks-sample" # (1)
eks_version = "1.29" # (2)
instance_type = "t2.micro" # (3)
min_worker_nodes = 1 # (4)
max_worker_nodes = 10 # (5)
desired_worker_nodes = 3 # (6)
}
