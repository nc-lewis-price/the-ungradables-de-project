resource "aws_iam_user" "test-user" {
  name = var.user-name

  tags = {
    Name    = "ungradables"
    Project = "totesys"
  }
}

resource "aws_iam_access_key" "user-key" {
  user = aws_iam_user.test-user.name
}

resource "aws_iam_user_login_profile" "test-login" {
  user                    = aws_iam_user.test-user.name
  password_reset_required = true
}

resource "aws_iam_user_policy" "admin-access-policy" {
  name   = "test-admin"
  user   = aws_iam_user.test-user.name
  policy = var.iam-policy-document
}
