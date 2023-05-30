variable "aws_region" {
  type    = string
  default = "us-east-1"
}
variable "cidr_block" {
  default = "10.0.0.0/16"
}
variable "aws_availability_zone" {
  type    = string
  default = "us-east-1f"
}
variable "instance_type" {
  type    = string
  default = "c4.xlarge"
}
variable "ssh_pub_path" {
  type        = string
  default     = "~/.ssh/id_rsa.pub"
  description = "Path to public key to use to login to the server"
}
variable "instance_ami" {
  type        = string
  default     = "ami-053b0d53c279acc90"
  description = "Instance AMI Linux AWS Ubuntu 22"
}
variable "spot_price" {
  type        = string
  default     = "0.16"
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
