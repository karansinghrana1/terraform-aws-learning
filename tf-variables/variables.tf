variable "aws_instance_type" {
  description = "what type of instance what to make"
  type = string
  validation {
    condition = var.aws_instance_type=="t3.micro" ||var.aws_instance_type=="t3.small"
    error_message = "only t3 micro and small allowed"
  }
}

variable "root_block_config" {
  type = object({
    v_size= number
    v_type= string
  })
  default = {
    v_size = 30
    v_type = "gp2"
  }
}

variable "root_volume_size" {
  description = "root volume size?"
  type = number
  default = 30
}

variable "root_volume_type" {
  description = "root volume type?"
  type = string
  default = "gp2"
}


variable "additional_tags" {
  type = map(string) #expect key value 
  default = {}
}