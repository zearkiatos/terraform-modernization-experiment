#main.tf
#defining the provider as aws
provider "aws" {
    region     = "${var.region}"
    access_key = "${var.aws_access_key}"
    secret_key = "${var.aws_secret_key}"
}
# Create SNS Queue
resource "aws_sns_topic" "orders" {
  name = "orders"
}

# Create SQS Queues
resource "aws_sqs_queue" "order-service" {
  name = "order-service"
}

resource "aws_sqs_queue" "daytrader-gateway" {
  name = "daytrader-gateway"
}

# Subscribe SQS Queues to SNS Topic
resource "aws_sns_topic_subscription" "order-service-subscription" {
  topic_arn = aws_sns_topic.orders.arn
  protocol  = "sqs"
  endpoint  = aws_sqs_queue.order-service.arn
}

resource "aws_sns_topic_subscription" "daytrader-gateway-subscription" {
  topic_arn = aws_sns_topic.orders.arn
  protocol  = "sqs"
  endpoint  = aws_sqs_queue.daytrader-gateway.arn
}
