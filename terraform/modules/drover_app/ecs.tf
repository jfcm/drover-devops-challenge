resource "aws_ecs_cluster" "main" {
  name = "drover-app-cluster"
}

data "template_file" "drover-app" {
  template = file("./modules/drover_app/config/app.json.tpl")

  vars = {
    drover_app_image = var.drover_app_image
    drover_app_port  = var.drover_app_port
    fargate_cpu      = var.fargate_cpu
    fargate_memory   = var.fargate_memory
    aws_region       = var.aws_region
  }
}

resource "aws_ecs_task_definition" "app" {
  family                   = "drover-app-task"
  execution_role_arn       = aws_iam_role.ecs_task_execution_role.arn
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = var.fargate_cpu
  memory                   = var.fargate_memory
  container_definitions    = data.template_file.drover-app.rendered
}

resource "aws_ecs_service" "main" {
  name            = "drover-app-service"
  cluster         = aws_ecs_cluster.main.id
  task_definition = aws_ecs_task_definition.app.arn
  desired_count   = var.app_count
  launch_type     = "FARGATE"

  network_configuration {
    security_groups  = [aws_security_group.ecs_tasks.id]
    subnets          = var.private_subnets_ids
    assign_public_ip = true
  }

  load_balancer {
    target_group_arn = aws_alb_target_group.app.id
    container_name   = "drover-app"
    container_port   = var.drover_app_port
  }

  depends_on = [aws_alb_listener.front_end, aws_iam_role_policy_attachment.ecs_task_execution_role]
}
