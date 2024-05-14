output "user-details" {
  value = {
    StartUrl        = "https://130861452270.signin.aws.amazon.com/console"
    Name            = aws_iam_user.test-user.name
    AccessKey       = aws_iam_access_key.user-key.id
    Password        = aws_iam_user_login_profile.test-login.password
    SecretAccessKey = aws_iam_access_key.user-key.secret
  }
  sensitive = true
}
