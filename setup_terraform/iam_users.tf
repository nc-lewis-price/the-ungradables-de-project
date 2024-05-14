resource "aws_iam_user" "test-user" {
  name = "test_user_2"

  tags = {
    Name    = "ungradables"
    Project = "totesys"
  }
}

resource "aws_iam_access_key" "user-key" {
  user = aws_iam_user.test-user.name
}

resource "aws_iam_user_login_profile" "test-login" {
  user    = aws_iam_user.test-user.name
}

resource "aws_iam_user_policy" "admin-access-policy" {
  name   = "test-admin"
  user   = aws_iam_user.test-user.name
  policy = data.aws_iam_policy_document.admin-access.json
}



output "user-details"{
    value = {
        Name = aws_iam_user.test-user.name
        AccessKey = aws_iam_access_key.user-key.id
        Password = aws_iam_user_login_profile.test-login.password
        SecretAccessKey = aws_iam_access_key.user-key.secret
    }
    sensitive = true
}