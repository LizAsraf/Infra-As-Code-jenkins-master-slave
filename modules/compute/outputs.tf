output "slave_instance_public_ip" {
  value = ["${aws_eip.slave_ip[*].public_ip}"]
} 
output "master_instance_public_ip" {
  value = ["${aws_eip.master_ip[*].public_ip}"]
} 
/* output "slave_instance_id" {
  value = aws_instance.slave.*.id
} 

output "master_instance_id" {
  value = aws_instance.master.*.id
}  */
