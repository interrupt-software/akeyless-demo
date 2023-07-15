terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}

resource "aws_iam_user" "trendy-tabby" {
  name = var.project-name
}

resource "aws_iam_access_key" "trendy-tabby" {
  user = aws_iam_user.trendy-tabby.id
}

resource "aws_iam_user_policy" "trendy-tabby" {
  name   = "${var.project-name}-policy"
  user   = aws_iam_user.trendy-tabby.id
  policy = <<EOF
{
	"Version": "2012-10-17",
	"Statement": [
		{
			"Action": [
				"ec2:*"
			],
			"Effect": "Allow",
			"Resource": "*"
		}
	]
}
EOF
}

data "aws_iam_group" "gc-aws-lab" {
  group_name = "gc-aws-lab"
}

resource "aws_iam_group_membership" "trendy-tabby" {
  name = "trendy-tabby"

  users = [
    aws_iam_user.trendy-tabby.name
  ]

  group = data.aws_iam_group.gc-aws-lab.group_name
}

