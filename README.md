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
* Improve Stability with Pod Disruption Budget. Fargate pods get patched and this way we ensure to limit the impact by setting minunvailable to 1 Unavailable at any given time 
* Create IAM OIDC provider Using Terraform
* Terraform ALB controller creation fails so create using steps from AWS official docs. 
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
	*  Vpc, route , subnets, gateway, nat etc and run 
        	terraform init, terraform apply
	*  Create eks and run terraform init, terraform apply
	*  Create fargate profiles - coreDNS etc . 
	*  Create additional fargate profile with namespace
        	terraform init, terraform apply
	*  Deploy Nginx sample app using helm (Edit and change the values as needed)
	*  Enable hpa settings optionally
	*  aws eks update-kubeconfig --name demo-nginx-cl-01 --region eu-central-1 
	*  kubectl create namespace staging
	*  helm repo add stable https://charts.helm.sh/stable
	*  helm repo update
	*  kubectl create namespace <namespace> (you can skip this as we already have a staging name space)
	*  helm install nginx-sample ./nginx-sample --namespace staging
	*  kubectl apply -f k8s # To create an ingress and PDB on staging namespace.

 Service be Cluster IP or NodePort - LB will create ALB. Unless needed we Opt to use ALB for this purpose
 
 	kubectl get deployment -n staging
  	kubectl get pods --namespace staging
 	kubectl get services --namespace staging
 	kubectl get svc --namespace staging
	kubectl get ingress --namespace staging
	kubectl get hpa -A

	* Add metrics-server.tf to monitor the pods
		terraform init
  		terraform apply
	* Remove and Redeploy coredns if the pods are not running
	* Alternative steps from AWS official docs to install the loadbalncer controller.
	* https://docs.aws.amazon.com/eks/latest/userguide/lbc-helm.html
```
  	curl -O https://raw.githubusercontent.com/kubernetes-sigs/aws-load-balancer-controller/v2.7.2/docs/install/iam_policy.json

	aws iam create-policy \
	  --policy-name AWSLoadBalancerControllerIAMPolicy \
	  --policy-document file://iam_policy.json

	eksctl create iamserviceaccount \
	  --cluster=my-cluster \
	  --namespace=kube-system \
	  --name=aws-load-balancer-controller \
	  --role-name AmazonEKSLoadBalancerControllerRole \
	  --attach-policy-arn=arn:aws:iam::111122223333:policy/AWSLoadBalancerControllerIAMPolicy \
	  --approve

	helm repo add eks https://aws.github.io/eks-charts
	helm repo update eks

	helm install aws-load-balancer-controller eks/aws-load-balancer-controller \
	  -n kube-system \
	  --set clusterName=my-cluster \
	  --set serviceAccount.create=false \
	  --set serviceAccount.name=aws-load-balancer-controller
	  --set region=eu-central-1 \
	  --set vpcId=vpc-id

	kubectl get deployment -n kube-system aws-load-balancer-controller ( You must see 2 replicas running and the LB is created. Verify from AWS console )
```
# Check Status
	kubectl get deployment -n kube-system
	kubectl edit deployment metrics-server -n kube-system

# Deploy busybox for load testing and hpa (Done) (TODO-DEMO)

	* Run Load test using below command . This can be useful to verify if HPA works correctly
	kubectl run -i --tty -n staging load-generator --pod-running-timeout=5m0s --rm --image=busybox:1.28 --restart=Never -- /bin/sh -c "while sleep 0.01; do wget -q -O- 		http://demo-nginx.mmscs.nl; done"

# Uninstall Instrucions
```     
	Go to AWS console and manually delete the Loadbalancer as this is not managed by terraform. 
	helm uninstall aws-load-balancer-controller eks/aws-load-balancer-controller -n kube-system
	eksctl delete iamserviceaccount --cluster=my-cluster --namespace=kube-system
	Or Use below command if that did not work 
	kubectl delete serviceaccount aws-load-balancer-controller -n kube-system
	aws iam delete-policy --policy-arn arn:aws:iam::230951218756:policy/AWSLoadBalancerControllerIAMPolicy
	terraform destroy
	If destroy did not work check the resources that was not deleted correctly, check the errors and ensure to delete them manually before recreating the cluster 
	Some times routes are not deleted correctly due to which VPC or Subnet associations are not removed. You can click and remove the VPC manually from Console.
```
