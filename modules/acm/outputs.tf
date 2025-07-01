output "ssl_output" {
  value = {
    ssl_wild       = aws_acm_certificate.wild_cert.arn
    ssl_pd         = aws_acm_certificate.pd_cert.arn
    ssl_ap         = aws_acm_certificate.ap_cert.arn
    # ssl_my_soasc   = aws_acm_certificate.my_soasc_cert.arn
    # ssl_api_soasc  = aws_acm_certificate.api_soasc_cert.arn
    ssl_wild_soasc = aws_acm_certificate.wild_soasc_cert.arn
  }
}
