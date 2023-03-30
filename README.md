# Dockerizing-App
I have created a Docker container for Ubuntu with MongoDB version 6.0
How to run a Dockerfile

# Step 1: 

Build an image 

cmd_1: docker build -t <image_name> .
               image name is (user defined)

# Step 2:


Run the image using the following command

cmd_2:   
docker run -it —name=<container_name> --entrypoint bash -d -e MONGO_USERNAME=<username> -e MONGO_PASSWORD=<password> -e MONGO_DB=<db_name> <image_name> -c "mongod"

# Step 3:  
exec command we use when docker container is already running, if you want to run it in interactive mode use the following command

cmd_3:  docker exec -it <container_name> /bin/bash

# Step 4: 
next we want to authenticate database which you want to create, open mongoDb shell
type
mongosh it will take you to the mongoDb shell, look like > test

Inside mongoDB shell type the following commands
cmds: 

use admin

db.createUser({user: "admin", pwd:"<password>", roles:[{role:"userAdminAnyDatabase",db:"admin"}]})

db.auth("admin","<password>")

use <db_name>
db.createUser({user: “<username>", pwd:"<password>", roles:[{role:”readWrite”,db:"<db_name>"}]})

Note: I keep the same db_name and username  as in cmd_2 

Now exit the mongoDB shell by typing exit
And to give authentication of readWrite to the above user <username> 
Type in terminal 

mongosh --authenticationMechanism SCRAM-SHA-256 --username <username> --password <password> "mongodb://localhost:27017/kmap_DATAV19" 

Here kmap_DATAV19 is the <db_name>
If you will not use -password above it will ask you then use the MONGO_PASSWORD

It will authenticate this user to read and write and will take you to the mongoDB shell. You may exit

You are all set! 


Note: You can run multiple terminal for the same container using 

docker exec -it <container_name> /bin/bash


