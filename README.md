# terraform-aws

terraform state
terraform state show
terraform state list
terraform state show aws_security_group.prod_web
terraform state show aws_s3_bucket.tf_course

terraform show
terraform show -json
terraform show -json | jq .
terraform graph

terraform plan -destroy -out=example.plan
terraform apply -out=example.plan
terraform apply example.plan

terraform apply
terraform apply example.plan

terraform plan -destroy -out=example.plan
terraform apply example.plan

10268  terraform show list
10269  more README.md
10270  terraform state list
10271  terraform state show aws_instance.prod_web
10272  terraform destroy
10273  terraform apply
10274  terraform state show aws_instance.prod_web
10275  terraform show
10276  terraform plan -destroy -out destroy.plan
10277  terraform apply "destroy.plan"
10278  git commit -am "Web instances and elastic ip"
10279  git push
10280  source $HOME/.zshrc
10281  git push
10282  terraform graph | grep -v -e 'meta' -e 'close' -e 's3' -e 'vpc'