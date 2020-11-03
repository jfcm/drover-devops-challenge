variable "vpc_cidr" {
   description = "VPC CICR block"
   default     = "172.17.0.0/16"
}

variable "az_count" {
  description = "Number of AZs to cover in a given region"
  default     = "2"
}