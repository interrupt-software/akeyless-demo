output "id" {
  value = aws_iam_access_key.trendy-tabby.id
}

output "secret" {
  sensitive = true
  value     = aws_iam_access_key.trendy-tabby.secret
}

output "public_dns" {
  value = aws_eip.trendy-tabby.public_dns
}

output "public_ip" {
  value = aws_eip.trendy-tabby.public_ip
}

# output "db_endpoint" {
#   value = aws_db_instance.postgres.endpoint
# }

# output "db_name" {
#   value = aws_db_instance.postgres.db_name
# }