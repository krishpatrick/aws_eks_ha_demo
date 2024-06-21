# aws_eks_ha_demo 
# Kris June 2024 kbn_micro

EKS infra setup - Terrform/Helm steps

Steps - Overview

* Create VPC Using Terraform
* Create AWS EKS Fargate Using Terraform
* Update CoreDNS to run on AWS Fargate Using Terraform
* Deploy Nginx sample App to AWS Fargate Using Helm
* Deploy Metrics Server to AWS Fargate
* Auto Scale with HPA Based on CPU and Memory
* Improve Stability with Pod Disruption Budget
* Create IAM OIDC provider Using Terraform
* Create IAM and follow steps for AWS Load Balancer Controller creation using AWS preferred method (https://docs.aws.amazon.com/eks/latest/userguide/lbc-helm.html)
* Deploy AWS Load Balancer Controller Using helm
* Create Simple Ingress using k8s
* Secure Ingress with SSL/TLS - Create certificate and update CNAME

Optional 
* Create Network Loadbalancer - By adding the correct k8s service type lb 
* Secure with SSL/TLS - Verify - optional

Steps - Raw Details

*  aws configure 
*  Then proceed with create prerequisite tf files
*  Vpc, route , subnets gateway nat etc and init and apply
*  Create eks
*  Create fargate profiles - coreDNS etc . 
*  Create additional fargate profile with namespace
*  Deploy Nginx sample app using helm (Edit and change the values as needed)
*  Enable hpa settings optionally
*  kubectl create namespace staging
*  helm repo add stable https://charts.helm.sh/stable
*  helm repo update

*  kubectl create namespace nginx-app (you can skip this as we already have a staging name space)
*  kubectl create namespace staging

 helm install nginx-sample ./nginx-sample --namespace staging

 Service be Cluster IP or NodePort - LB will create NLB. Unless needed we Opt to use ALB for this purpose
 kubectl get deployment -n staging

  	kubectl get pods --namespace staging
 	kubectl get services --namespace staging
 	kubectl get svc --namespace staging
	kubectl get ingress --namespace staging
	kubectl get hpa -A


 metrics-server.tf to monitor the pods

 terraform init
 terraform apply

# issues and Status
kubectl get deployment -n kube-system
kubectl edit deployment metrics-server -n kube-system

Change to new error 403 forbidden by fargate for metrics server , Moving on ( TODO)

# Deploy busybox for load testing and hpa (Done) (TODO-DEMO)

ALB did not work 

Error is here#
  Warning  FailedDeployModel  5s    ingress  Failed deploy model due to AccessDenied: User: arn:aws:sts::xxxxxxx:assumed-role/aws-load-balancer-controller/1718902250792467738 is not authorized to perform: elasticloadbalancing:AddTags on resource: arn:aws:elasticloadbalancing:eu-central-1:xxxxxxx:targetgroup/k8s-staging-nginxsam-7ece1bb95a/* because no identity-based policy allows the elasticloadbalancing:AddTags action
           status code: 403, request id: 860a2149-def0-4c04-a80e-51f05699bcf7

Used other Alternative steps to isolate the issue. It could be something in the policy creation. so backed up these tf files for analyzing further. 

Plan A did not work, Plan B FOLLOWED AWS DOCUMENTATION STEPS USING HELM/EKSCTL

 Ingress host field did not work, Analyzing. Removed - 
 Issue fixed during SSL setup.

* Run Load test using below command . This can be useful to verify if HPA works correctly
kubectl run -i --tty -n staging load-generator --pod-running-timeout=5m0s --rm --image=busybox:1.28 --restart=Never -- /bin/sh -c "while sleep 0.01; do wget -q -O- http://demo-nginx.mmscs.nl; curl http://demo-nginx.mmscs.nl;  done"

# TODO
 Security
 Documentation Work
 Pros and Cons Doc
 Arch Diagram
 Module'ise Terra 
 Terra Best practices in AWS
 Remember to gitignore
