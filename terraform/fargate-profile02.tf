resource "aws_eks_fargate_profile" "staging" {
  cluster_name           = aws_eks_cluster.cluster2.name
  fargate_profile_name   = "staging"
  pod_execution_role_arn = aws_iam_role.fargate_pod_execution_role2.arn
  subnet_ids = [
    aws_subnet.private2-eu-central-1a.id,
    aws_subnet.private2-eu-central-1b.id
  ]

  selector {
    namespace = "staging"
  }
}
