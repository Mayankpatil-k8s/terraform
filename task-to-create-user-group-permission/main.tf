resource "aws_iam_user" "devUsers" {
  name = "devUsers"
}

resource "aws_iam_user" "prodUsers" {
  name = "prodUsers"
}


resource "aws_iam_group" "devGroup" {
  name = "dev"
}


resource "aws_iam_group" "prodGroup" {
  name = "prod"
}

resource "aws_iam_group_membership" "addingDevUser1ToGroup" {
  name = "testing-group-membership-dev"
  users = [aws_iam_user.devUsers.name]
 
  group = aws_iam_group.devGroup.name
}

resource "aws_iam_group_membership" "addingProdUserToGroup" {
  name = "testing-group-membership-prod"
  users = [aws_iam_user.prodUsers.name]
 
  group = aws_iam_group.prodGroup.name
}




resource "aws_iam_policy" "policy" {
  name        = "test_policy"
  description = "My test policy"

 
  
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "s3:*"
        Effect   = "Allow"
        Resource = "*"
      },
    ]
  })
}


resource "aws_iam_group_policy_attachment" "test-attach" {
  group      = aws_iam_group.devGroup.name
  policy_arn = aws_iam_policy.policy.arn
}
