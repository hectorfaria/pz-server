// UNCOMMENT IF YOU WANT THIS
/* resource "aws_globalaccelerator_accelerator" "ga" {
  name            = "ga"
  ip_address_type = "IPV4"
  enabled         = true
}

resource "aws_globalaccelerator_listener" "ga-udp-1" {
  accelerator_arn = aws_globalaccelerator_accelerator.ga.id
  protocol        = "UDP"
  client_affinity = "SOURCE_IP"

  port_range {
    from_port = 16261
    to_port   = 16261
  }
}
resource "aws_globalaccelerator_listener" "ga-udp-1" {
  accelerator_arn = aws_globalaccelerator_accelerator.ga.id
  protocol        = "TCP"
  client_affinity = "SOURCE_IP"

  port_range {
    from_port = 16262
    to_port   = 16262
  }
}

resource "aws_globalaccelerator_endpoint_group" "ga" {
  listener_arn = var.ga_listener
  health_check_interval_seconds = 10
  health_check_path = "/health"
  health_check_protocol = "HTTP"
  threshold_count = 2

  endpoint_configuration {
    endpoint_id = aws_alb.instance
    weight      = 100
  }
} */
