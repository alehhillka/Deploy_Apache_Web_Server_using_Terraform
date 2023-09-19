# Створення Target Group
resource "aws_lb_target_group" "apache" {
  name        = "apache-target-group"
  port        = 80
  protocol    = "HTTP"
  vpc_id      = aws_vpc.vpc.id

  #Налаштування health check
  health_check {
    path                = "/healthcheck"  # Шлях для перевірки здоров'я (повинен бути на вашому веб-сервері)
    interval            = 30              # Інтервал перевірок в секундах
    timeout             = 5               # Таймаут перевірки в секундах
    healthy_threshold   = 3               # Кількість послідовних успішних перевірок для позначки як здоровий
    unhealthy_threshold = 2               # Кількість послідовних неуспішних перевірок для позначки як нездоровий
  }
}

# Прикріплення Target Group до Auto Scaling Group
resource "aws_autoscaling_attachment" "asg_attachment" {
  autoscaling_group_name = aws_autoscaling_group.apache.name
  lb_target_group_arn   = aws_lb_target_group.apache.arn
}
