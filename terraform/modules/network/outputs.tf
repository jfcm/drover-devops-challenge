output "vpc_id" {
  value = aws_vpc.main.id
  description = "The VPC ID"
}

output "public_subnets_ids" {
  value = aws_subnet.public.*.id
  description = "The public Subnets ID"
}

output "private_subnets_ids" {
  value = aws_subnet.private.*.id
  description = "The private Subnet ID"
}