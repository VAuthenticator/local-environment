resource "aws_iam_access_key" "test" {
  user = aws_iam_user.vauthenticator.name
}