output "vpc" {
  value = module.my-vpc.vpc-id
}
output "public-subnet" {
  value = module.my-vpc.public-subnets
}

output "private-subnet" {
  value = module.my-vpc.private-subnets
}