output "ec2_id" {
  value = aws_instance.web[0].id
  description = "The ID of the EC2 instance"
}