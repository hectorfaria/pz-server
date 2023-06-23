# Project Zomboid Template server (WIP)

TODO:
terraform:
Create VPC gateway endpoints for S3 to save money    
Move S3 to terraform
Add Global Accelerator
On Start-up
On Delete

Ansible:
Make pzuser on Ansible
Add AWSCLI on Ansible

Misc:
Add prometheus for monitoring
Maybe using EventBridge to decouple on deletion                                              

Make your own project zomboid server on AWS, fully customizable!, The repository uses Spot Instances to save as much money possible, S3 to save files and Global Accelerator for less latency.

This repository uses:

 - AWS (ec2,s3,Cloud Accelerator)
 - Ansible
 - Terraform
 - Vagrant

Steps to recreate:

Before running the code

   Create your own ansible inventory it should look something like this
    
    pzserver ansible_host=
    [pzserver]
    pzserver ansible_python_interpreter=/usr/bin/python3

    [pzserver:vars] 
    ansible_user=pzuser
    ansible_ssh_private_key_file=zomboid.pem

Add your pem key and rename it `zomboid.pem` make sure it's for your pzuser, otherswise change `ansible_user` to ubuntu/centos/ec2-user, whatever OS you are using.

Optionally you can use the `Vagrantfile`, to recreate locally and run the ansible first to make sure everthing works.

Create an IAM Role for s3, this repository saves it's config in s3

Run the Terraform file

- Connect to the instance and create the user `pzuser`
- Get the IP of the connection and run the Ansible file remotely. (Make sure you have the zomboid.pem for the pzuser not the original one.
- If you have already a Zomboid folder (with the server configuration) upload it from your s3
- Run the server `cd /home/pzuser` and `start-zomboid && screen -r`
- Stop the Instance
- Create an AMI from it
- Change the AMI variable in the terraform file

Now all you have to do is `terraform plan` and `terraform destroy` whenever you want to run your server!