# ALB Security Group: Edit to restrict access to the application
resource "aws_security_group" "lb" {
  name        = "load-balancer-security-group"
  description = "controls access to the ALB"
  vpc_id      = var.vpc_id

  # SG Inbound rules open for TCP connection
  ingress {
    protocol    = "tcp"
    from_port   = var.drover_app_port
    to_port     = var.drover_app_port
    cidr_blocks = ["0.0.0.0/0"]
  }

  # SG Outbound rules open for TCP connection
  egress {
    protocol    = "-1"
    from_port   = 0
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Traffic to the ECS cluster should only come from the ALB
resource "aws_security_group" "ecs_tasks" {
  name        = "drover_app-ecs-tasks-security-group"
  description = "allow inbound access from the ALB only"
  vpc_id      = var.vpc_id

  ingress {
    protocol        = "tcp"
    from_port       = var.drover_app_port
    to_port         = var.drover_app_port
    security_groups = [aws_security_group.lb.id]
  }

  egress {
    protocol    = "-1"
    from_port   = 0
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }
}