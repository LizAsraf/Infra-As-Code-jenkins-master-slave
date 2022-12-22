output "security_groups" {
  value = aws_security_group.tcp_ssh.id
}
output "role_name" {
  value = aws_iam_role.role.name
}
output "profile_name" {
  value = aws_iam_instance_profile.profile.name
}