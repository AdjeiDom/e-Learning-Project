
data "aws_route53_zone" "betheldom" {
  name                   = var.zone-name
  private_zone           = false
}

# Provides a Route53 record resource.
## Simple routing policy & Alias record
# TTL for all alias records is 60 seconds, you cannot change this, therefore ttl has to be omitted in alias records.

resource "aws_route53_record" "betheldom-academy" {
  zone_id = data.aws_route53_zone.betheldom.zone_id
  name    = var.record-name
  type    = var.alias-record-type
  
  alias {
    name                   = aws_lb.elearn-alb.dns_name
    zone_id                = aws_lb.elearn-alb.zone_id
    evaluate_target_health = var.alias-target-evaluate
  }
}



