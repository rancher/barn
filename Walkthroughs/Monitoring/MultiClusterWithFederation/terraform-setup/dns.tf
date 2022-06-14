data "digitalocean_domain" "zone" {
  name = "plgrnd.be"
}

resource "digitalocean_record" "downstream_one" {
  domain = data.digitalocean_domain.zone.name
  type   = "A"
  name   = "*.downstream-one"
  value  = sort(local.worker_ips_downstream_one)[0]
  ttl    = 60
}
output "dns_downstream_one" {
  value = digitalocean_record.downstream_one.fqdn
}

resource "digitalocean_record" "downstream_two" {
  domain = data.digitalocean_domain.zone.name
  type   = "A"
  name   = "*.downstream-two"
  value  = sort(local.worker_ips_downstream_two)[0]
  ttl    = 60
}
output "dns_downstream_two" {
  value = digitalocean_record.downstream_two.fqdn
}

resource "digitalocean_record" "central_monitoring" {
  domain = data.digitalocean_domain.zone.name
  type   = "A"
  name   = "*.central-monitoring"
  value  = sort(local.worker_ips_downstream_central_monitoring)[0]
  ttl    = 60
}
output "dns_central_monitoring" {
  value = digitalocean_record.central_monitoring.fqdn
}
