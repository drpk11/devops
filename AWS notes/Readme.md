AWS

Security group basically acts as layer of security to EC2 instances/application. There are 2 types ie inbound n outbound, inbound any request to the application/ec2 instance n outbound is any from the app/ec2 to external . 

NACL(n/w access control lists), which basically a security instance to the subnet(vpc—>gateway—>route(ip tables)—>subnets(nacl )—>security group—>ec2.) here d concept says , suppose any developer wants to use ec2 instance with opening port allowing traffic, where there might be security breach, here nacl helps. Ie AWS deny the traffic and allows only ports that r set up.


S3: simple storage and locally accessible. It can store file, excel, video ,any thing —these r called objects. So when objects are uploaded in s3, there is a high reliability ie even if s3 in one availability zone goes down , it is accessible cuz of its relocation mechanism, aws s3 has replicas of the objects  based on avavilabity . It is scalable, secure, available n durable, performance, cost effective . It is 99.99999999999 reliable.it also enable versioning control, ex uploaded object file has few changes. This updated file can be uploaded, and under version we have both old file n current version of file.


——
CFT:

Infrastructure as code has a principle that when a user submits a template (json, yaml which is declartive and versioned ) to a tool(CFT) it submits to cloud to create .(Cloud understands this through an API calls.)
user(yaml, json)—>CFT(IAC) —>CLOUD(through api calls)

Declarative temp—> what u see is what u hv

CLI->when we want to perform some quick actions like details log aws
CFT->when u want to actually create resources.

Drift detection-> when even any changes are made like to enable or disable , CFT notifies the changes done. 
 
YAML template contains: version,decription,metadata,parametrs,rules,mapping(assigning parameters),conditions, resources, output 

Stack-> implement template which converts into api calls

——— 
Ci/cd can be implemented through aws also ie, generally ci/cd need git, Jenkins, build stages  and implmetating on docker/kubernetes, similarly aws allows code commit(GitHub), aws pipeline(Jenkins), Aws build(build stage),aws deploy(deployment of docker/kubernetes)

Codecommit :
Private repository  only in organization
Create repo- store code 

On ui- we can create one repo at once; but if we want to create mutiple we , we use visual studio or terminal 
SSH is not recommendable in aws as it is not secure

Disadvantages:
Less Features
Aws restricted
Less integrations with services outside aws


———
Through terminal we’ll login to ec2instance using command: 
 ssh -I  ~/Downloads/aws_login.pem (location of login .pem file) ubuntu@54.89.185.123

U will install an agent ie ham role in ec2 to communicate with code deploy

——
CLOUD WATCH IS like a gate keeper for aws cloud which helps to understand monitor, alert,repoting and logging generally a tracking .

Exploring e2 cloud watch 
SNS- Simple notification service

——
AWS Lambda functions:
Es2- virtual compute having cpu requirements, memory
S3 resolves the problem of serverless
Lambda belongs to compute services and solves the problem of server less 

Major diff between ec2 and lambda is server less architecture

Aws will automatically create a compute depending on requirements . 
We don’t need to tell aws the we need 8gb cpu or 16gb cpu , it automatically creates and scales up n down.

EC2 is pay as u use, where u have to tear down the instance, while lambda does itself. Ex: if there an food delivery app, n the user request and place the order through checkout form and payment method, here the user will not use payment again, ie only when user creates a request aws will create the infrastructure for running the application, once the user job is done, it will tear down the instance.

Ec2 requires manually scaling up n down.
We don’t know what is the ip address , autoscaling ; Lamda instance 
So, if we have to use ec2 or server less is not decided by devops but business, developers or architecture team. As devops team u have to create lambda function if necessary for cost optimization .

Serverless helps in cost optimization n security / compliance.

We need to add triggers , this can  be done from cloud watch , let say if cpu is reached 50 % trigger and direct to lambda function.

Use cost optimization cuz of overhead costs n cost infrastructure. 
Backup-snapshots

Stale resources- someone has created but forgot to delete it

Here lambda function are written in 1 programming language le say python , these will talk to aws api to do required actions

Default execution  time of lambda function is 3 sec

When one service talk to another service, this can happen through IAM role
—————

Cloud Front:
Suppose, we have a user from Instagram accessing a video or image , this instagram server has a central storage where it generally stores its info’s info which is stored in S3. Let say suppose, a user1 from India wants to access other user2 image or video , here we have 3 issues, latency, security and cost. SO, here we have CDN-Cloud delivery Network, which basically uses cloud front, where it uses edge as cache store where this CDN creates a copies of data and placed in edge wherein , the user1 from India can access to nearest edge of mirrored data of user 2. There by, resolving issues like latency which is reduced, cost and security wherein the user is not access s3 storages

—————————

ECR(Elastic Container Registry)
Elastic means it is highly stable and available; Container- where u contain ur app code and s/w update ; Registry- it is a container registry similar to docker registry .
If u hv a docker image/container  image  at local laptop and want other to use it, u can just place ur image in container registry.

ECR VS DOCKER HUB
Docker hub - is generally a public repo, where all ur images are created and used , we do have private repo ,but by default it is set to public repo
Where as ECR- is a private repo, generally organization use images within n don’t expose them and it is secure when compared to docker hub. Also, AWS users can use ECR with IAM roles already created where in for using docker hub, the users have to login/register. 

————————
AWS ECS

Elastic container service.
It is  aws Container Orchestration Environment(COE) where it is not open source. Disadvantage is its does not use other containers from other cloud, mainly if u want to move from aws to azure , already present resources in aws will make it difficult, so… 

Kubernetes is open source n popular ..

———————————
EKS 

ELASTIC kUBERNETES SERVICE : Let say u have Kubernetes where u have 2 planes ie control plane(master node) and Data plane(worker node), in control plane we have different components like api, etcd, scheduler, cloud controller etc all these components are managed manually suppose we hv any issues like API server is down , or scheduler not working, or etcd crashed, all these issues hv to to be fixed manually which leads to Application downtime, HERE EKS from AWS helps to maintain this Control plane of managing these components from AWS. Also ur worker nodes can be managed by Margate which is a server less computing service like EC2. 
Here Lambda functions maintain low workloads for a runtime , but fargate is highly available and maintains heavy workloads.

Now Suppose, we have EKS platform ie cluster we hv 3 master nodes n 2 worker nodes, n ur app is deployed in pod using kubctl it has a cluster ip address and cannot be accessed by external world, for this we create a service in this we hv 3 modes as discussed cluster ip model(only accessible within cluster), node port mode(can be accessed to which ever ec2 ip addresss when kubernetd deployed , only who has assess to private subnet), load balancer(creates a ip address from public subnet but it is costly , ) since it is costly we use INGRESS , OUTSIDE THE SERVICE well maintain an ingress controller where the external user access the application through ingress  where it routes the ip tables, in ingress yaml we’ll write script that whenever a user wants to access it request the service and further the pod to access . Now we just created an ingress resource with yaml file instructions inside the private subnet, now user from outside first will have to enter to public subnet through load balancer then the ingress controller(nginx) will manages and ingress resource  from load balancer where it creates let say nginx control will configure its load balancer and check the instructions from ingress resource and forwards the request.

Using ingress class, well know ho has the control etc,
—————————
Secrects management on aws

To secure passwords like docker username, password, registry , databases user name , pass ,ansible, terraform etc has to  be secured . We have Systems management, Secrects Manager, Hashicorp vault(not aws). 

We can use systems manager when its not sensitive info like user name , registry can be stored in it, where as u can store passwords in secret manger which allows u to rotate the password in fixed time period say 90 days, 270 days etc and is costly when compared to systems manager.

Hashicorp value is used when u r using multi cloud like aws or azure , or transition from aws to azure or any other cloud platform. encryption is enabled

———————————
 Load Balancer

It is used to handle multiple request to access the server (ec2), it handles downtime and slow processing of the application. Load balancer helps to navigates multiple requests by sending into different servers(ec2). We have 3 load balancer mainly Application Load Balancer(ALB), Network Load B(NLB), Gateway Load Balancer(GWLB). 

Application load balancer (Layer 7)handles the request at http other ftp levels, let say if amazon.com/payments  is used it will direct to payments server , similarly to transaction etc. ALB will intercept the request and securely sends to the server, hence it is costly because it has the capability to intercept and analyze ie a hop and at the same time it is slow.provides additional or advance load balancing techniques.

Network Load Balancer acts at the transport layer 4, where it routes the tables to have low latency and high transmission of data like gaming, streaming , YouTube etc. Here there is no delay of transmission of data. 

So, ALB can be used when u want to intercept at http layer with a delay, n NLB without delay of low latency with TCP/UDP also it uses sticky sessions for like YouTube etc.

GWLB is used when u hv virtual appearance like vpn or firewall, firewall cannot be handled by alb or nlb cuz they r not highly secure as gwlb.
————————————

Redis - in memory data store(ex: Cart in amazon/any shopping )
Micro service - different logic like backend has ex: shipping, payments, user, catalogue, etc 
EBS(Persistent volume) and Redis is not supported by Fargate while creating in EKS
————————
SHELL SCRIPTING

$# - Pass the no.of arguments
$0 - variable name ex: ./aws_resource.sh <region_name> <service> ie ./aws_resource is variable and arguments are region n service

How shell communicates with aws : through aws CLI instead of API calls(where u need to authenticate for each service using curl comm) ; similar if using python u communicate via Boto 3 to AWS
