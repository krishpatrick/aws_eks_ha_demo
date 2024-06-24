resource "aws_eks_fargate_profile" "fp-default" {
  cluster_name           = aws_eks_cluster.cluster2.name
  fargate_profile_name   = "fp-default2"
  pod_execution_role_arn = aws_iam_role.fargate_pod_execution_role2.arn
  subnet_ids = [
    aws_subnet.private2-eu-central-1a.id,
    aws_subnet.private2-eu-central-1b.id
  ]

  selector {
    namespace = "default"
  }

  selector {
    namespace = "kube-system"
  }
}

resource "aws_iam_role_policy_attachment" "AmazonEKSFargatePodExecutionRolePolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSFargatePodExecutionRolePolicy"
  role       = aws_iam_role.fargate_pod_execution_role2.name
}

resource "aws_iam_role" "fargate_pod_execution_role2" {
  name                  = "eks-fargate-pod-execution-role2"
  force_detach_policies = true

  assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": [
          "eks.amazonaws.com",
          "eks-fargate-pods.amazonaws.com"
          ]
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
POLICY
}

