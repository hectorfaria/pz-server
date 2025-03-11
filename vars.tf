variable "aws_region" {
  type    = string
  default = "us-east-1"
}
variable "cidr_block" {
  default = "10.0.0.0/16"
}
variable "aws_availability_zone" {
  type    = string
  default = "us-east-1d"
}
variable "instance_type" {
  type    = string
  default = "t3a.xlarge"
}
variable "spot_price" {
  type        = string
  default     = "0.05"
  description = "Maximum price to pay for spot instance"
}
variable "spot_type" {
  type        = string
  default     = "one-time"
  description = "Spot instance type, this value only applies for spot instance type."
}
variable "spot_instance" {
  type        = string
  default     = "true"
  description = "True if we want to use a spot instance instead of a regular one"
}
