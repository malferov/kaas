data "aws_route53_zone" "zone" {
  name = var.domain
}

resource "aws_route53_record" "app" {
  zone_id = data.aws_route53_zone.zone.zone_id
  name    = "${var.app}.${var.domain}"
  type    = "A"
  ttl     = "60"

  records = [
    "kubectl get ingress app -o=json | jq .status.loadBalancer.ingress[].ip",
  ]
}
