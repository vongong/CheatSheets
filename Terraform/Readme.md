
## What is Terraform
- Automate and mange Infrastructure
- Open Source
- Declarative
- Univeral Tool for Provisioning IaC
- Ansible is for configuration
- Relatively new

**Architecture Core**
- inputs
  - TF-Config = Configuration
  - TF-State = Current state
- Core takes inputs and create plan what needs to happen. (Execution Plan)
- providers - IaaS PaaS SaaS - Execute Execution Plan

**Commands**
init - install providers that are reference
refresh - query provider to get updated state
plan - create execution plan (preview)
apply - Execute plan
destroy -  remove the resources/infrastructure

## Setup
Install Locally = package manager or download binary

Verify: `terraform -v`

## Provider
- Connect to a technology - interact w APIs and access to all APIs
- Allows terraform to talk to a technology
- [Browse Providers](https://registry.terraform.io/)
- Not automatically included since there are so many. Its modular.
- Install Provider: `terraform init`

## Resource
Create new resource with `resource` key. 
Resource type naming using [provider]_[resourceType]
variable name is the next part

```js
// Create aws vpc with a variable name dev-vpc
resource "aws_vpc" "dev-vpc" {
    cidr_block = "10.0.0.0/16"
}

// Create subnet assoc dev-vpc
resource "aws_subnet" "dev-subnet-1" {
    vpc_id = aws_vpc.dev-vpc.id
    cidr_block = "10.0.10.0/24"
    availability_zone = "eu-west-3a"
}
```

Apply Changes: `terraform apply`

Data Source = Allow data to be fetched in TF config
```js
// create subnet in existing vpc
data "aws_vpc" "existing-vpc" {
    default = true
}

resource "aws_subnet" "dev-subnet-2" {
    vpc_id = data.aws_vpc.existing-vpc.id
    cidr_block = "172.31.48.0/20"
    availability_zone = "eu-west-3a"
}
```

## Datatype
- string
- bool
- number
- list([type])
- map

## Variable precedence
- Environment Variable
  - Environment Variable with prefix "TF_VAR_" will assigned values to variables
  - TF_VAR_sec_vnet_id will assign value to sec_vnet_id
- Variable Defination file (.tfvars)
- Variable Defination json file (.tfvars.json)
- Command Line -var or -var-file

## for Loops:
tuple:
  [for item in items : tuple_element]
  local {
    toppings = ["cheese", "lettuce", "salsa"]
  }
  [for t in local.toppings : "super ${t}"]
  #results = ["super cheese", "super lettuce", "super salsa"]
object:
  {for key, value in map : object_key => object_value}
  local {
    prices = {
      taco = 2.99
      burrito = 9.99
      enchilada = 3.99
    }
  }
  { for k, v in local.prices : k => ceil(v) }
  results: { taco = 3, burrito = 10, enchilada = 4 }


## Common Functions
- Numeric
- String
- collections
- IP network
- Filesystem
- Type Conversion

## Function Testing: 
via Console

## Modules
- Versioned like Providers
- Already using - Root Module
- only way to pass data from Parent Module to Child Module is by inputs and output variables

