# Project Zomboid Template server (WIP)

TODO:
terraform:
Move S3 to terraform
Add Telegram API bot
On Delete

Ansible:
Make pzuser on Ansible
Add AWSCLI on Ansible
change ec2 default user to pzuser

Misc:
Add prometheus for monitoring
Maybe using EventBridge to decouple on deletion                                              

Make your own project zomboid server on AWS, fully customizable!, The repository uses Spot Instances to save as much money possible, S3 to save files and Global Accelerator for less latency.

This repository uses:

 - AWS (ec2,s3,Cloud Accelerator(optional))
 - Ansible
 - Terraform
 - Vagrant

Steps to recreate:

Before running the ansible files

   Create your own ansible inventory it should look something like this
    
    pzserver ansible_host=
    [pzserver]
    pzserver ansible_python_interpreter=/usr/bin/python3

    [pzserver:vars] 
    ansible_user=pzuser
    ansible_ssh_private_key_file=zomboid.pem

Add your pem key and rename it `zomboid.pem` make sure it's for your pzuser, otherswise change `ansible_user` to ubuntu/centos/ec2-user, whatever OS you are using.

Optionally you can use the `Vagrantfile`, to recreate locally and run the ansible first to make sure everthing works.

Before running the Terraform files

- Connect to the instance and create the user `pzuser` and make sure is the cloud init default user
- Get the IP of the connection and run the Ansible file remotely. (Make sure you have the zomboid.pem for the pzuser not the original one.
- If you have already a Zomboid folder (with the server configuration) upload it from your s3
- Make sure you can run seamlessly the zomboid server
- Stop the Instance
- Create an AMI from it
- Make sure you change the variables suited for your region,spot price, and subregion in the terraform file
- Create a file named secrets.tf like this:

 variable "instance_ami" {
  type        = string
  default     = "<your-ami>"
  description = "Your custom PZ instance"
  sensitive   = true
}

variable "bucket_name" {
  type      = string
  default   = "<your-bucket-name>"
  sensitive = true
}

Now all you have to do is `terraform apply` and `terraform destroy` whenever you want to run your server!
