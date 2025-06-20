Docker 

Lets say VM’s which has its own OS with hypervisor have no.of ec2 instances or memory which is being unused or running out of memory, when thousands of GB is unused or have add sepate vm it is a serious loss for the business IT, there is a concept of containers where where is only 1 OS or VM/EC2 with Docker platform to run containers are light weight and have minimal OS ie  Base image (os +application dependencies +packages)

pull
 docker                   Run
			start
			stop
			run -d : use terminal again

			run -p6000;6
			ps
			images
Docker logs docherid/containerid
Docker run -d -p6001:6548 —name redid-older radio:4.0


Docker compose- to have multiple docker containers in 1 file
Command:  docker -compose -f mongo.yaml up { f-file  n what f it wants to do , it wants to start all the containers present in docker ie ‘up’}

Docker tag = is to rename the container 


Servicenow: there r 2 important aspects or a part of service tool ie
1)incident management: suppose if these any leaks or application related issues it has to send alerts to the specific team/ person to handle ,so this monitoring tool helps ie service now helps to identify the issue n assign to specific team or person with let to fix it
2)change management: as the alerts are issued , any changes to prod cannot happen immediately or each time a issue is raised it cannot fix with mutilple person working on prod, so for that it first arranges with teams or vendors to work  like to start the start or test it or deploy or any such has to be informed to customers as period of downtime ,and all these changes are tracked in this change management.



Docker bind n volume
— bind is used ex: 1)lets say a container has nginx layer or image where it racks the employees activities to container and this container store log files , suppose this container s down  the data might be lost  2) second ex: suppose we hv front end and back end containers  suppose if the back end container is down, there might be a downtime for front end  3) suppose an application container  has dependencies on separate file, it cannot use or add that to directory of container etc 
 For these issues we hv bind mounts : let say we hv a container on host , and a file which binds both conatainer n host, this means  the folder still hv info about the details even if the conatainer fails/ down , where suppose if we create another container this folder and be mount to container which exists on host and makes work better, here the host to be assigned to specific folder on container  Next volumes, here the host is built on volumes and volume has logical creation on ec2, host, external devices 

 Docker volume ls—shows list of volumes
Docker volume create Dharani 
Docker volume rm Dharani
Docker volume inspect Dharani 


Docker Networking:
- Suppose to connect / communicate from 1 container to other container or to the host , we hv different n/w’s 1)bridge n/w  2) host n/w-binds host n/w with container n/w 3) overlay n/w -used for multiple bridges; 
- most host n/w is not applicable n secure as the container r secure, if the complete os / n/w has all the packages included which might be unnecessary can make the nw insecure; if u hv common nw system , someone who has access to host can access conatainer which should not be d case.
Coming to bridge n/w : suppose u hv container which has its own n/e 172.16.2.1 and host has n/w eth192.31.2.2 , where there’s no way of communicating , here docker comes with a a solution of having separate virtual n/w with docker 0 which binds both container n docker . Suppose, if there r 2 container s and wants to connect it can ping with each network , if other container wants to be isolated with another container but it has to talk to host to do operation , here we build a custom bridge which sepately connects host n isolated container.


Dockerlifecycle
 if there s requirement from project to container an app, initially uu wrote a docker file ,a set of instruction to run the app, once it is complete , all create an image out of it using build command-which converts docker file to docker image , after than u run the command -to create and execute the container and use push the image to external registry(docker hub,ec2 etc)


Docker components:
We have a docker client (like build, run, deploy) which is CLI these instruction are taken by docker daemon (contains container and images) which is the heart od docker system performs or executes action of the instruction provided , after executing these it will push to external registry .

Docker add - can copy files from url using curl or wget ; where as Docker copy file from host to container


--------------------

create a container: 
#check if u have base image (ex:ubuntu), then create a container
docker run -it --name container1 ubuntu

#update 
apt-get update
#setup ssh
apt-get install openssh-server
#install nano package
apt-get install nano
#change the authenticate password with yes by omitting probit password in /nano /etc/ssh/sshd_config file 
#check the status
service --status -all
#set a password to 1st unbuntu cont
passwd root
#set a password
#execute opeartions inside cont 
docker exec -it cont1 bash 

#similarly create a ubuntu cont 2 and install openserver-client on it. This is to establish connection btw 2 container, check whether cont1 ssh is started using docker ssh start command. Later, through conatiner 2 connect to cont 1 with the password which is setup in 1st cont.
