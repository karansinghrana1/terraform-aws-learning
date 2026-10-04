terraform {
  required_providers {

    aws = {
      source  = "hashicorp/aws"
      version = "6.67.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}

#user role pair
locals {
  users_data = yamldecode(file("D:/terraform/aws-iam-management/users.yaml")).users

  user_role_pair = flatten([for user in local.users_data: [for role in user.roles:{
    username=user.username
    role = role
  }]])
}





#creating user 

resource "aws_iam_user" "users" {
    for_each = toset(local.users_data[*].username)
  name = each.value
}


#password creation
resource "aws_iam_user_login_profile" "name" {
  for_each = aws_iam_user.users
  user = each.value.name
  password_length = 12
  lifecycle {
    ignore_changes = [
      password_length,
      password_reset_required,
      pgp_key,
    ]
  }
}

#attaching policy
resource "aws_iam_user_policy_attachment" "main" {
    for_each = {
        for pair in local.user_role_pair : "${pair.username}-${pair.role}" => pair
    }

  user= aws_iam_user.users[each.value.username].name
  policy_arn = "arn:aws:iam::aws:policy/${each.value.role}"
}



output "output" {
  value = local.user_role_pair
}