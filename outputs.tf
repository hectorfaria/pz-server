output "pzserver-ip" {
  value       = var.spot_instance == "true" ? "${aws_spot_instance_request.pz-spot[0].public_ip}" : "${aws_instance.pz-server[0].public_ip}"
  description = "Spot intstance IP"
}

output "private_key" {
  value       = tls_private_key.zomboid_key.private_key_pem
  description = "Private Key"
  sensitive   = true
}
