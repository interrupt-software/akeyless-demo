output "id" {
    value = aws_iam_access_key.trendy-tabby.id
}

output "secret" {
  sensitive = true
  value     = aws_iam_access_key.trendy-tabby.secret
}
