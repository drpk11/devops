Terraform:
To automate the infrastructure without the use of AI
Can support mutiple cloud

If u want to create more than 1 s3 bucket  without manual , we can use  program like CLI, API-Where program is written n executed . Not only s3 , if we need two create vpc, vac config, ec2.. we need program, where aws allows heavy lifting by providing cloud formation templates(CFT ) WHERE IT allows to create/write infrastructure as code. Just write like need s3, e2 in form of template ie in json or yaml format or any scripting like python ,shell,.. THAT is infracture as code,

Each cloud provider need its own template like aws, azure, gcp, openstack. Where terraform gives a universal approach, just give which cloud provider u want. We need to know hashicorp template language(HCL). If we need from aws, this HCL will convert into aws api and execute, similarly other cloud providers.

——————————

Variables : input (where u provide the arguments/parameters); output like ip address(expect the terraform will provide once terraform apply is applied)

Main.tf has:
Provider.tf
Input.tf
output.tf
Main.tf
Terraform .tfvars(when using a hybrid cloud often there might be changes let say in size of t2.micro we can have t3.medium) how to parameterize like these ;   
—————
Modules are created when u have monolithic applications where u have millions of code n if there any bug , it has issues like ownership(which part of code ), maintenance ,testing, u have to search where the bug is ,fix  it test it all in one code

———————
Statefile is the heart of terraform and records or store the in fracture that has created.
Suppose let say terraform has created an ec2 instance and stored , so when not time the same instance is created with diff type etc, when terraform apply is applied it recognizes the ec2 instances and just updates instead of creating. When tag is changed.

Here we have 2 issues,whenever ur tf is executed there is state file created in local , and suppose let they in a group od devops u share it, when one person make changes without apply, there will miss the state file  or when git is compromise . Next issue is , always a devops person after code changes has to upload the state file to git .
These issues can be fixed by Remote backend ie ur statefile stores in s3 bucket/any remote backend, n can apply rules of who can access.here ur state file is not in tf main project but somewhere else.

Along with the state file , there is a lock file created , ie cuz when 1 or more users make changes to the code and execute it , this lock will help to execute the tf one user ta a time, ie whenever user 1 is executing the tf is locked n kept private policy and other user has to wait until  it is done who is public , when done, user 2 can make it private n execute. This can be achieved by using DynamoDB
————-
In tf, inbound traffic is defined as Ingress and outbound traffic as egress 
—————————

Workspaces

Let say we have different env dev, stage n prod and for each env ur developer ask configuration instance type is different say dev env needs t2.micro, stage needs t3.medium and prod t3.xlarge . Now using tf when u use modules along with tfvars to implement and apply these there can be chaos as we hv one state file whenever a dev env is executed it saves the changes now when stage env is executed the state file will update it and dev env instance type is also updates  . Hence, to have different env to have different state file we use workspaces , where each has a separate state file.

