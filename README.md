# terraform-kubernetes-kops

Prerequisites :

Installing Kops Binary on Linux Machine:

1.  curl -Lo kops https://github.com/kubernetes/kops/releases/download/$(curl -s https://api.github.com/repos/kubernetes/kops/releases/latest | grep tag_name | cut -d '"' -f 4)/kops-darwin-amd64
chmod +x ./kops
sudo mv ./kops /usr/local/bin/

Installing Kubectl Binary on Linux Machine :

2.  curl -Lo kubectl https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl
chmod +x ./kubectl
sudo mv ./kubectl /usr/local/bin/kubectl

3. Create an AWS S3 Bucket.

We also need to create an S3 bucket which kops will use to save the cluster’s state files.



EKS cluster launch using KOPS :
===============================

This settings uses 1 Master and 2 worker nodes in us-east-2 region.

1.  Configure AWS SDK cli, on any linux instance of your choice, In my case I have used ec2-Amazon Linux, as this was pre=-installed.

2.  $ aws configure

AWS Access Key ID: YOUR_ACCESS_KEY
AWS Secret Access Key: YOUR_SECRET_ACCESS_KEY
Default region name [None]:
Default output format [None]:


3.  Please note, the AWS IAM User above needs to have administrator access.

4.  In my case I created a bucket name : s3://com.bittu.jha

5.  ensure public/private ssh key pair exists, if not create using "ssh-keygen -t rsa"  command.

6. kops create secret --name bittu.k8s.local --state "s3://com.bittu.jha" sshpublickey admin -i ~/.ssh/id_rsa.pub

7.  kops create cluster --state "s3://com.bittu.jha" --zones "us-east-2a,us-east-2b"  --master-count 1 --master-size=t2.micro --node-count 2 --node-size=t2.micro --name bittu.k8s.local --ssh-public-key=~/.ssh/id_rsa.pub --yes

8.  kops update cluster --name bittu.k8s.local --state "s3://com.bittu.jha"  --yes

9. kops validate cluster --state "s3://com.bittu.jha" --name bittu.k8s.local

10.  Now our EKS cluster is ready to use and install applications.


   kubectl get svc
This will output, the NLB endpoint, open the url in browser, It should print the Revision:2. on home page.



Finally delete the EKS cluster :

kops delete cluster --state "s3://com.bittu.jha" --name bittu.k8s.local --yes



      ############################################################### END of KOPS ####################################################################
      ############################################################### END of KOPS ####################################################################



Creating an Standalone Linux Instance :
=======================================

1). Go to standalone_ec2_instance folder, replace the Access_key and secret_key in variables.tf file with your user access details.

2). Run
         #terraform init
         #terraform plan
         #terraform apply

3). This will have you new instance created.



      ############################################################### END of Standalone Linux  Instance ####################################################################
      ############################################################### END of Standalone Linux  Instance ####################################################################







EKS cluster launch using Terraform :
==================================

1). Go to eks_cluster_using_terraform/modules/eks/providers.tf folder, replace the Access_key and secret_key in providers.tf file with your user access details. Also please make sure to pass any SSH keypair name to the variables.tf file.

2). Run
         #terraform init
         #terraform plan
         #terraform apply

3). Wait while the new EKS cluster is created.




4). To install aws-iam-authenticator on Linux follow below steps :

# curl -o aws-iam-authenticator https://amazon-eks.s3-us-west-2.amazonaws.com/1.10.3/2018-07-26/bin/linux/amd64/aws-iam-authenticator
# chmod +x ./aws-iam-authenticator
# mv aws-iam-authenticator /usr/local/bin/


5). Run below command to  update kube-config,  Please make sure you have the "aws configure" command setup prior to running this step.

  aws eks --region us-east-2 update-kubeconfig --name my-cluster


6). Authorize worker nodes
Get the config from terraform output, and save it to a yaml file:

       # terraform output config-map > config-map-aws-auth.yaml


8). Apply the config map to EKS:

       # kubectl apply -f config-map-aws-auth.yaml
You can verify the worker nodes are joining the cluster

9). kubectl get nodes --watch


10). Cleaning up
You can destroy this cluster entirely by running:

terraform plan -destroy
terraform destroy  --force


12). Run below command to get the EKS load balancer endpoint, hit on the browser, the sample nginx page is ready to server traffic.

    # kubectl get svc



	  ############################################################### END of EKS cluster using Terraform ####################################################################
      ############################################################### END of EKS cluster using Terraform ####################################################################
