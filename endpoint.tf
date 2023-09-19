# # Створення VPC Endpoint для S3
# resource "aws_vpc_endpoint" "s3_endpoint" {
#   vpc_id      = module.vpc.vpc_id
#   service_name = "com.amazonaws.eu-central-1.s3"  # Замініть на свій регіон AWS
#   policy = <<EOF
# {
#   "Version": "2012-10-17",
#   "Statement": [
#     {
#       "Effect": "Allow",
#       "Principal": "*",
#       "Action": "*",
#       "Resource": "*"
#     }
#   ]
# }
# EOF

#   load_balancer_arns = [data.aws_lb.my_web_alb.arn]  # Використовуємо load_balancer_arn з даних про ALB
# }


# resource "aws_lb_listener" "web" {
#   load_balancer_arn = data.aws_lb.my_web_alb.arn
#   port              = 80
#   protocol          = "HTTP"

#   default_action {
#     type = "fixed-response"

#     fixed_response {
#       content_type = "text/plain"
#       status_code  = "200"
#     }
#   }
# }

