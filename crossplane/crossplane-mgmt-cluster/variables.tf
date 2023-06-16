variable "subnet_ids" {
  type        = list
  default     = ["subnet-03ec249894b880bfb", "subnet-0b22a7f9041754cae"]
  description = "subnet ids"
}

variable "vpc_id" {
    type = string
    default = "vpc-0c932199b7926a2ef"
}

variable "cidr_block" {
    type = list
    default = ["165.225.57.182/32"]
}