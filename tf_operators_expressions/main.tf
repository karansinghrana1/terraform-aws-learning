terraform {}

# number list

variable "num_list" {
  type = list(number)
  default = [ 1,2,3,4,5 ]
}

# object list

variable "person_list" {
  type = list(object({
    fname=string
    lname=string
  }))

  default = [ {
    fname = "karan"
    lname = "rana"
  },{
    fname = "sham"
    lname = "paul"
  } ]
}


variable "map_list" {
  type = map(number)
  default = {
    "One" = 1
    "two" = 2
  }
}


#calculation
locals {
  mul = 2 * 2
  add = 2 + 9

  # triple the number
  triple = [for num in var.num_list : num * 3]
  #odd number
  odd_numer=[for num in var.num_list : num if num%2 != 0]
  eq = 2!=3

  #only 1st name
  fname = [for person in var.person_list : person.fname]

  #only key

  key_from_map = [for key,value in var.map_list : key]

  #double map
    double_map = {for key,value in var.map_list : key=>value*6}

}





output "name" {
  value = local.double_map
}

