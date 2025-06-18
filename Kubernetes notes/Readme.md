Kubernetes
Intro 
 problem 1) single host nature on docker:Container r ephemeral in nature ie they r short , they die or can revive anytime. Suppose a docker has 100 containers where if there’s a memory allocation issue IE IF ONE CONATINER USES MORE MEMORY , the the last conatiiner may not get started or can die, this is cuz of single host on docker where they can be impact between the container to not come up.

Problem 2) whenever a container is killed by kernel or by any means , there might be 100 reasons of y container r killed , when container r killed application is not accessible, for that reason users or developer hv to restart the conatainer. For 1 we can restart but if we hv thousands of container, it is not possible to check docker ps command and check which containers r not working so for this we use or there must be  AUTO HEALING METHOD

Problem 3) absence of auto scaling feature in docker: suppose if there r thousands of user requests(ex: Netflix during holiday season ) , even if the container  uses all the cpu n gb from host, that is less, the container cannot handle for this there must be manual increase of container let say from 1 to 10 or automatically increase container, for which docker does not support auto scaling, we need to have a load balancer suppose we hv 2 containers , how will u manage the users , load balancer helps conatainers to manage among themseleves-user requests .

Docker is simple which does not support enterprise level platforms (which includes auto scaling, healing, api gateways, firewalls, load balancer) SO all these problems r solved by KUBERNETES.

Lets talk about how Kubernetes resolve these issues: 1) single host : this can be solved by have a cluster of Kubernetes in the host or master node. Ie if the if the 1st container uses more menmory and 1ooth container does not hv memory to run n execute, this Kubernetes sepates the 100th container into a sepate nose has Kubernetes has a multi node structure, where 1st container doesn’t effect the 100th container. 

2)next auto scaling- here whenever these is a increase in requests , Kubernetes uses replicator sets or controller to create another conatiner n manage requests, this is done through yaml file to increase the containers-manual way . This is also be done through Horizontal pod autoscaler where once the container reaches 80% or so, it automatically creates another one to manage .

3. Next is Healing- Kubernetes generally  controls the damage by whenever the container is down , which is indicated by api server, it creates a new container ie roll out a new one even before it goes down.

Docker is never used in prod server

————————————————————
Kubernates architecture:
Briefly, we have Master plane n Data plane 
First discussing about data plane, which is in worker node-:like docker has conatainer, here we hv Kubernates has pods ie , kuberlet a component is responsible for that pod is always running and if not working , it forms API server(which is in master plane). Next in data plane we hv container runtime like containers in docker uses container runtime to execute the container other can be docker shim; like wise we hv container runtime in worker node.Next we hv Kubernetes proxy to manage the n/w, like we hv docker 0 in bridge n/w  , here Kube proxy is responsible for n/w management.

Coming to Master plane we hv API server as discussed , it uses makes sure the pod r running, suppose when a user wants to create a pod in worker node, the API server checker and assign to create a pod in node 1 this can be done using a Scheduler which actually executes the operation of API server, here it API server act like instructor . Next , we hv Controller manager, it manages the replica pods or container ie load balancer and responsible for auto scaling.Next we hv Cloud controller Manager - suppose if there a request lo  create load balance or storage the underlying cloud service to implement Kubernetes has to submit scripts to cloud control manager..ex:  to implement Kubernetes I its application, Cloud controller manager helps AWS cloud. Next to store or hv backup of Kubernetes we ETCD.

—————
HOW DO U MANAGE 100’s of kubenete cluster — we do it using KOPS , this deals with installations, deletions, upgrade , modifications which is basically a lifecycle

———
To run Kubernetes we use kubectl commands, like docker commands cli

———
Kubernetes deployment
Let first understand container vs pods vs deploy
Conatiner: docker runs the container  using command ie docker run -d image : ___     :name:—  :port:80:80 Pod : we use yaml command where we hv all the commands in 1 file and further if pods has more than 1  container wants to share resources they can use shared n/w inside pod .  
Here the main reason to use deploy is that it supports auto healing n auto scaling ie docker doesn’t support n pod just create file 
Deploy generally makes sure that pod is running always even if it killed , it creates another pod specified
 Noe this deployment has replica sets which executes the specified pods or containers, we have Deploy—> replica—> Pod
So, when u deploy a specific yaml file  where the script provides or user request to hv more replicas , the replica set which is a controller manage ensures that the pods are created and maintained .

So we don’t deploy a pod , we deploy a deployment
________________

Kubernetes service:

Suppose if the deployment has 3 replicas with their ip address , if user wants to access, there might not be able to access the n/w , this can be done by using Service ie SVC- Where it forward the request of url of ip address . 
So SVC need load balancer, and suppose even if the url ip address is changed as these can be tracked. N there’s no traffic. This can be resolved using service discovery. Which uses labels and selectors
So instead of url , users can use label name to access .
NEXT is to expose  it to outside world OF Kubernetes, we use SVC. This needs YAML file to hv cluster ip(discovery ; inside org), node port (inside org)n Load balancer(external world)

So , if user wants to access (let say from his home wifi) to organization n/w we need a public ip addresss. So , this public ip address is provided by Cloud Control manager like aws(aws—> eks—> elf—>public ip) . This public ip address is given by sec to org whoever or user wats to access , they can use this public ip to access pods or app.

——
Diff btw docker swarm n Kubernetes : swarm is used for small scale app n not scalable. But Kubernetes is used for large org as other offers scalability like policies n third party ecosystem.

Diff btw docker container n kubernetes pod: a pod in Kubernetes is a runtime specification of a container  in docker.A pod provides more declarative way of defining using YAML n u can run more than 1 container in pod.
  
What is namespace in Kubernetes? It is a logical isolation of resources ,n/w ,policies ,brace n everything. Ex: there r 2 projects using same k8s cluster. 1 project can use ns1 n other can use ns2 without any overlap authentication problem.

Diff types of services of k8’s:  Cluster ip mode- anyone inside org who has cluster ip node port mode: anyone inside org who has port address  load balancer - outside
		 
—————
Commands:
Kubectl build name kubernetes
Kubectl apply -f deployment.yml— applying the kubenets file created 
Kubectl get deploy
Kubectl get pods—info of pods
Kubectl get pods -o wide - info with n/w

So, whenever u delete one pod let say -kubctl delete pod pod name; this will delete the pod with the allocated ip address let say it has 172.17.0.6, now this replica concept comes into pic of healing it ie creating the no.of pod of mentioned in yml file, when it creates an other pod automatically , it creates an ip address which is different, so, when user is trying the pod which is lost through ip address , it cannot be fetched, so here is the topic SERVICE DISCOVERY MECHANIC ARRIVES LIKW LABEL N SELECTORS. Here, the label is same whenever a new pod is created .

———————————I
To expose ur cluster ; we can use services like Cluster ip address to communicate within cluster; nodeport : to use ports instead of p address(as the can change dynamically ie different ip address); load balancer- to have a public ip address using cloud controller mechanism using aws or azure but at enterprise level its does have issues like routing , to have static ip 

ingress solves the problem of having a single or static ip address and using the services or exposing the Custer to external user , also it resolves its routing tables.

TLS: 
SSL pass through  where client sends request through http to load balancer simply pass to app server through https but compromise security. 
Another is SSL Offloading where the load balancer decrypts the and sends the request when u want less latency. SSL bridge which is secure and check the packets read it inspects  and if correct n nor malicious sends to server n recommendable.


When a user creates a yaml file ,  non sensitive data which is stored in etcd with api server in config map , hacker point,solve the encrypted data which etcd and and sensitive info in backed by RBAC which is limited to few users  
—————————————

Service will able to discover the pods using labels and selectors
