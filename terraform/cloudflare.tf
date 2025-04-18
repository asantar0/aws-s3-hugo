resource "cloudflare_dns_record" "site_cname" {
  zone_id = var.zone_id
  name    = var.site_domain
  content = aws_s3_bucket_website_configuration.static_site_configuration.website_endpoint
  type    = "CNAME"

  ttl     = 1
  proxied = true
}

resource "cloudflare_dns_record" "www" {
  zone_id = var.zone_id
  name    = "www"
  content = var.site_domain
  type    = "CNAME"

  ttl     = 1
  proxied = true
}

/*resource "cloudflare_cloud_connector_rules" "cloud_connector_rules" {
  zone_id = var.account_id
  rules = [{
    #id          = ""
    description = "AWS S3 Connector"
    enabled     = true
    expression  = "http.cookie eq \"a=b\""
    parameters = {
      host = "http://agustin-s.s3-website-us-east-1.amazonaws.com"
    }
    cloud_provider = "aws_s3"
  }]
}*/
