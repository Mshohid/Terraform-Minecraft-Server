# A Minecraft server deployed using Terraform and AWS 
Having used AWS Cloudformation, but never used Terraform I thought why not learn while building my own minecraft server.
This server can be made easily and cheaply by purchasing a plan from a hosting provider, but theres no fun in that.
However, I highly recommend a hosting provider if you want to create a personal server for the long term as it is considerably cheaper.

# main.tf
main.tf is a blueprint of the infrastructure.
It builds:
 - A new VPC
 - A new internet gateway
 - A new subnet
 - A route table 
 - A security group (Allows SSH and TCP from your IP only, so if you want to invite friends you will need to add their IP address or make TCP traffic publicly available)
 - An Ec2 instance (The server)
 
note: Terraform does not allow you to create a Ec2 key pair, so create a key pair beforehand.

# userdata.sh (Not yet finished)
A bash script that will update the server and install the necessary sofware packages. 
  
