output "vpcid" {
  value = aws_vpc.main.id
} 
output "vpcname" {
  value = aws_vpc.main.tags.Name
} 

output "subnet" {
  value = aws_subnet.subnet.*.id
}