# aws_eks_ha_demo 
# Kris June 2024 kbn_micro

EKS infra setup - Terrform/Helm steps

# aws configure 
# Then proceed with create prerequisite tf files
# Vpc, route , subnets gateway nat etc and init and apply
# Then create eks
# Then create fargate profiles - coreDNS etc . 
# Create additional fargate profile with namespace
# Deploy Nginx sample app using helm (Edit and change the values as needed)
# 	Enable hpa settings optionally
# kubectl create namespace staging
# helm repo add stable https://charts.helm.sh/stable
# helm repo update

# kubectl create namespace nginx-app (you can skip this as we already have a staging name space)

# kubectl create namespace staging

# helm install nginx-sample ./nginx-sample --namespace staging

# Service be Cluster IP or NodePort - LB will create NLB. Unless needed we Opt to use ALB for this purpose
# kubectl get deployment -n staging

  	kubectl get pods --namespace staging
 	kubectl get services --namespace staging
 	kubectl get svc --namespace staging
	kubectl get ingress --namespace staging
	kubectl get hpa -A


# metrics-server.tf to monitor the pods

 terraform init
 terraform apply

# issues
1181  kubectl get deployment -n kube-system
 1182  kubectl edit deployment metrics-server -n kube-system

Change to new error 403 forbidden by fargate for metrics server , Moving on ( TODO)

# Deploy busybox for load testing and hpa (Skipped) (TODO)

ALB did not work 

Error is here#
  Warning  FailedDeployModel  5s    ingress  Failed deploy model due to AccessDenied: User: arn:aws:sts::xxxxxxx:assumed-role/aws-load-balancer-controller/1718902250792467738 is not authorized to perform: elasticloadbalancing:AddTags on resource: arn:aws:elasticloadbalancing:eu-central-1:xxxxxxx:targetgroup/k8s-staging-nginxsam-7ece1bb95a/* because no identity-based policy allows the elasticloadbalancing:AddTags action
           status code: 403, request id: 860a2149-def0-4c04-a80e-51f05699bcf7
  Warning  FailedDeployModel  4s  ingress  Failed deploy model due to AccessDenied: User: arn:aws:sts::xxxxxxx:assumed-role/aws-load-balancer-controller/1718902250792467738 is not authorized to perform: elasticloadbalancing:AddTags on resource: arn:aws:elasticloadbalancing:eu-central-1:xxxxxxx:targetgroup/k8s-staging-nginxsam-7ece1bb95a/* because no identity-based policy allows the elasticloadbalancing:AddTags action
           status code: 403, request id: 6e408e0c-e7a0-4732-910c-4a39099f9270

Used other Alternative steps to isolate the issue. It could be something in the policy creation. so backed up these tf files for analyzing further. 

Plan A did not work, Plan B temporary manual steps - tested and working fine, Plan C Fresh Terraform code for Creating ALB controller, Plan D - Terrform to apply iamroles/policies and use plain helm to deploy 

# Ingress host field did not work, Analyzing. Removed 

# Enabled SSL on existing ALB

#TODO
# Security 
# Documentation Work
# Pros and Cons Doc
# Arch Diagram
# Module'ise Terra 
# Terra Best practices in AWS
# Remember to gitignore
