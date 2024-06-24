resource "aws_eks_addon" "coredns" {
  addon_name        = "coredns"
  addon_version     = "v1.11.1-eksbuild.9"
  cluster_name      = "demo-nginx-cl-02"
  resolve_conflicts = "OVERWRITE"
  #depends_on        = [module.eks-cluster]
}
