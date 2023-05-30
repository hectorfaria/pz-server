output "ubuntu_ip" {
  value       = aws_eip_association.ip-vps-env.public_ip
  description = "Spot intstance IP"
}
