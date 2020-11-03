# Set up CloudWatch group and log stream and retain logs for 30 days
resource "aws_cloudwatch_log_group" "drover_app_log_group" {
  name              = "/ecs/drover_app"
  retention_in_days = 30

  tags = {
    Name = "cb-log-group"
  }
}

resource "aws_cloudwatch_log_stream" "drover_app_log_stream" {
  name           = "drover-app-log-stream"
  log_group_name = aws_cloudwatch_log_group.drover_app_log_group.name
}
