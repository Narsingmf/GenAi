output "instance_id" {
  description = "ID of the EC2 instance"
  value       = aws_instance.ec2_instance.id
}

output "private_ip" {
  description = "Private IP of the EC2 instance"
  value       = aws_instance.ec2_instance.private_ip
}

output "security_group_id" {
  description = "ID of the security group attached to the EC2 instance"
  value       = aws_security_group.ec2_sg.id
}