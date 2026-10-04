terraform {}


locals {
  value = "helLLo wOOOOord"
}

variable "string_list" {
  type = list(string)
  default = [ "s1","s2","s3","s1" ]
}

# output "result" {
#   value = lower(local.value)
# }
# output "result" {
#   value = upper(local.value)
# }
# output "result" {
#   value = startswith(local.value,"hello")
# }

# output "result" {
#   value = split(" ",local.value)
# }

# output "result" {
#   value = min(1,2,3,4)
# }

# output "result2" {
#   value = max(1,2,3,4)
# }

# output "result" {
#   value = abs(-15)
# }

# output "result" {
#   value = length(var.string_list)
# }

# output "result" {
#   value = join(":",var.string_list)
# }

# output "result" {
#   value = contains(var.string_list,"s1")
# }

output "result" {
  value = toset(var.string_list)
}