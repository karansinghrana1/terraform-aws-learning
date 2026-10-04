ec2_cinfig = [ {
  ami = "ami-0b6d9d3d33ba97d99"
  instance_type = "t3.nano"
},
{
    ami = "ami-0d27e0fb3bac4d724"
    instance_type = "t3.nano"
} ]


ec2_map = {
  "ubuntu" = {
    ami = "ami-0b6d9d3d33ba97d99"
  instance_type = "t3.nano"
    
  },
  "amazon" = {
    ami = "ami-0d27e0fb3bac4d724"
    instance_type = "t3.nano"
  }
}