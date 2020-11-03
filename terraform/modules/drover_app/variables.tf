# Providers Vars
variable "aws_region" {
  default = "eu-west-2"
}

# Network Vars
variable "vpc_id" {}
variable "private_subnets_ids" {}
variable "public_subnets_ids" {}

# ECS Vars
variable "ecs_task_execution_role_name" {
  description = "ECS execution role name"
  default = "EcsExecutionRole"
}

variable "drover_app_image" {
  description = "Docker image to run in the ECS cluster"
  default     = "nginx:latest"
}

variable "drover_app_port" {
  description = "Port exposed by the docker image to redirect traffic to"
  default     = 80
}

variable "app_count" {
  description = "Number of docker containers to run"
  default     = 3
}

variable "health_check_path" {
  default = "/"
}

variable "fargate_cpu" {
  description = "Fargate instance CPU units to provision (1 vCPU = 1024 CPU units)"
  default     = "1024"
}

variable "fargate_memory" {
  description = "Fargate instance memory to provision (in MiB)"
  default     = "2048"
}