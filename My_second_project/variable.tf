variable "subnet" {
  type        = string
  default     = "subnet-0acfe16f068da06d7"
  description = "subnet id"
}
variable "ami" {
  type        = string
  default     = "ami-0715c1897453cabd1"
  description = "Amazon Linux AMI"
}
variable "instance_type" {
  type        = string
  default     = "t2.micro"
  description = "type of instance"
}
