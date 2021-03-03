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

# userdata.sh
A bash script that will update the server and install the necessary sofware packages.
The script itself will update the instance and install the (current) latest verison of java. In case this particular version of java may no longer be the latest either:
- edit "yum install java-1.8.0-openjdk -y" in the userdata.sh to whatever java version is the latest. 
- delete that line of userdata.sh and do "yum list available | grep java" (To list all versions of Java), followed by "sudo yum install <latest version of java> -y" (To install that version of Java).
 

# Next steps 

1. SSH into your EC2 instance. (If you are unable to SSH into it, change the rules of the security group to allow all ssh traffic for now. Change it after starting the server)
2. Enter https://www.minecraft.net/en-us/download/server so we can download the server file
3. Instead of saving the server.jar file to your local machine, right click and copy the link address. 
4. "wget <file link>" e.g "wget https://launcher.mojang.com/v1/objects/1b557e7b033b583cd9f66746b7a9ab1ec1673ced/server.jar"
5. Use "ls" to list all the files in the directory. There should be a new file called server.jar
6. Use "java -Xmx1024M -Xms1024M -jar [file_name].jar nogui" to start your server e.g "java -Xmx1024M -Xmx1024M -jar server.jar nogui" (This command is on the same page we downloaded our server file from)
7. It will error. Thats ok! "vi" (Or the whichever preferred text editor) into eula.txt and on the 4th line change "eula=false" to "eula=true".
The server is now ready!
8. Just open minecraft > click multiplayer > add server > enter the public ip address of your server.
