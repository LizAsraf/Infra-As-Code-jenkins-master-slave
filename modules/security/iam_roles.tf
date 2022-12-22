resource "aws_iam_role" "role" {
  name = "liz_role"
  path = "/"
  tags = merge(
    var.tags,
    {
      Name = "${var.enviroment}-iam_role-liz"
    },
  ) 
  assume_role_policy = <<EOF
  {
      "Version": "2012-10-17",
      "Statement": [
          {
              "Action": "sts:AssumeRole",
              "Principal": {
                "Service": "ec2.amazonaws.com"
              },
              "Effect": "Allow",
              "Sid": ""
          }
      ]
  }
  EOF
}

resource "aws_iam_instance_profile" "profile" {
  name = "liz_profile"
  role = aws_iam_role.role.name
}

data "aws_iam_policy" "ecr" {
  name        = "EC2InstanceProfileForImageBuilderECRContainerBuilds"
}

resource "aws_iam_role_policy_attachment" "attach-also-ecr" {
  role       = aws_iam_role.role.name
  policy_arn = data.aws_iam_policy.ecr.arn
}