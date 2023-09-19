# Створення SNS теми для сповіщень
resource "aws_sns_topic" "notifications" {
  name = "apache-notifications"
}