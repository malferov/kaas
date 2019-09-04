data "template_file" "secret" {
  template = file("manifest/secret.yml.tpl")

  vars = {
    cer = base64encode("${acme_certificate.cert.certificate_pem}${acme_certificate.cert.issuer_pem}")
    key = base64encode(acme_certificate.cert.private_key_pem)
  }
}

resource "local_file" "secret" {
  content  = data.template_file.secret.rendered
  filename = "manifest/secret.yml"
}

data "template_file" "http" {
  template = file("src/http.conf.tpl")

  vars = {
    domain = var.domain
    app = var.app
  }
}

resource "local_file" "http" {
  content  = data.template_file.http.rendered
  filename = "src/http.conf"
}
