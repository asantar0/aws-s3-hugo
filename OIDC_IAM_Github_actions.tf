resource "aws_iam_openid_connect_provider" "github_oidc" {
  url = "https://token.actions.githubusercontent.com"

  client_id_list = [
    "sts.amazonaws.com"
  ]

  thumbprint_list = [
    "6938fd4d98bab03faadb97b34396831e3780aea1"
  ]
}

resource "aws_iam_policy" "github_actions_policy" {
  name        = "S3GitHubActionsPolicy"
  description = "Policy to allow GitHub Actions to put objects in the dennis-static-site S3 bucket."

  policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Action" : [
          "s3:ListBucket"
        ],
        "Effect" : "Allow",
        "Resource" : [
          "arn:aws:s3:::agustin-s"
        ]
      },
      {
        "Action" : [
          "s3:PutObject",
          "s3:DeleteObject"
        ],
        "Effect" : "Allow",
        "Resource" : [
          "arn:aws:s3:::agustin-s/*"
        ]
      }
    ]
  })
}

resource "aws_iam_role" "github_actions_role" {
  name                = "S3GitHubActionsRole"
  description         = "Role to use for GitHub Actions."
  managed_policy_arns = [aws_iam_policy.github_actions_policy.arn]

  assume_role_policy = jsonencode(
    {
      "Version" : "2012-10-17",
      "Statement" : [
        {
          "Effect" : "Allow",
          "Principal" : {
            "Federated" : aws_iam_openid_connect_provider.github_oidc.arn
          },
          "Action" : "sts:AssumeRoleWithWebIdentity",
          "Condition" : {
            "StringEquals" : {
              "token.actions.githubusercontent.com:aud" : aws_iam_openid_connect_provider.github_oidc.client_id_list
            },
            "StringLike" : {
              "token.actions.githubusercontent.com:sub" : "repo:asantar0/aws-s3-hugo:*"
            }
          }
        }
      ]
    }
  )
}
