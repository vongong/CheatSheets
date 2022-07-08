# help command baked in to the cli.
terraform version
terraform -help

# Now we will follow the standard Terraform workflow
terraform init
terraform fmt
terraform validate
terraform plan -out m3.tfplan
terraform apply "m3.tfplan"

# If you are done, you can tear things down to save $$
terraform destroy

########################

# We will pass our variables at the command line
terraform plan -var=billing_code="ACCT8675309" -var=project="web-app" -var=aws_access_key="YOUR_ACCESS_KEY" -var=aws_secret_key="YOUR_SECRET_KEY" -out m4.tfplan

# And we can store our sensitive data in environment variables like so
# For Linux and MacOS
export TF_VAR_aws_access_key=YOUR_ACCESS_KEY
export TF_VAR_aws_secret_key=YOUR_SECRET_KEY

# For PowerShell
$env:TF_VAR_aws_access_key="YOUR_ACCESS_KEY"
$env:TF_VAR_aws_secret_key="YOUR_SECRET_KEY"

########################
# access state file
terraform state list
terraform state show aws_instance.nginx1

########################
# test function with console
terraform init
terraform console

# Now we can try some different functions and syntax
min(42,5,16)
lower("TACOCAT")
cidrsubnet(var.vpc_cidr_block, 8, 0)
cidrhost(cidrsubnet(var.vpc_cidr_block, 8, 0),5)
lookup(local.common_tags, "company", "Unknown")
lookup(local.common_tags, "missing", "Unknown")
local.common_tags


########################
# workspace
terraform workspace list

terraform workspace new Development
terraform plan -out m9dev.tfplan
terraform apply m9dev.tfplan

terraform workspace new UAT
terraform plan -out m9uat.tfplan
terraform apply m9uat.tfplan

terraform workspace select Development
terraform destroy -auto-approve

terraform workspace select UAT
terraform destroy -auto-approve

terraform workspace show
terraform workspace delete Development
terraform workspace delete UAT