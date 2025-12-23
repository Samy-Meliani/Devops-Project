module "sample_app" {
source = "github.com/Samy-Meliani/Devops-Project.git/devops_base/td2/scripts/tofu/live/sample-app"
ami_id = "ami-2phl8129aga323800"
name = "sample-app-from-github"
}

