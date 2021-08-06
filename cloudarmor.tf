# Creates a Security Policy with the predefined rules configured 
# refer to official documentation page for more info https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_security_policy

resource "google_compute_security_policy" "policy" {
  name        = local.WAF_NAME
  description = "WAF Security Policy Rules"
  project     = data.google_project.primary.number

  # Deny SQLi Rule
  rule {
    action   = "deny(403)"
    priority = "1"
    match {
      expr {
        expression = "evaluatePreconfiguredExpr('sqli-stable',['owasp-crs-v030001-id942420-sqli','owasp-crs-v030001-id942421-sqli','owasp-crs-v030001-id942260-sqli','owasp-crs-v030001-id942340-sqli','owasp-crs-v030001-id942431-sqli','owasp-crs-v030001-id942432-sqli','owasp-crs-v030001-id942420-sqli','owasp-crs-v030001-id942421-sqli','owasp-crs-v030001-id942200-sqli','owasp-crs-v030001-id942430-sqli','owasp-crs-v030001-id942330-sqli'])"
      }
    }
    description = "Deny SQL injection (SQLi) attacks"
  }

  # Deny XSS Rule
  rule {
    action   = "deny(403)"
    priority = "2"
    match {
      expr {
        expression = "evaluatePreconfiguredExpr('xss-stable')"
      }
    }
    description = "Deny Cross-site scripting (XSS)"
  }

  # Deny LFI Rule
  rule {
    action   = "deny(403)"
    priority = "3"
    match {
      expr {
        expression = "evaluatePreconfiguredExpr('lfi-stable')"
      }
    }
    description = "Deny Local file inclusion (LFI) attacks"
  }

  # Deny RFI Rule
  rule {
    action   = "deny(403)"
    priority = "4"
    match {
      expr {
        expression = "evaluatePreconfiguredExpr('rfi-stable')"
      }
    }
    description = "Deny Remote file inclusion (RFI) attacks"
  }

  # Deny RCE Rule
  rule {
    action   = "deny(403)"
    priority = "5"
    match {
      expr {
        expression = "evaluatePreconfiguredExpr('rce-stable')"
      }
    }
    description = "Deny Remote code execution (RCE) attacks"
  }

  # Allow Authorized Domains
  rule {
    action   = "allow"
    priority = "6"
    match {
      expr {
        expression = "request.headers['Host'].matches('(?i:${var.DOMAIN_NAME})')"
      }
    }
    description = "Allow Only Authorized Domains"
  }

  # Default Deny Rule
  rule {
    action   = "deny(403)"
    priority = "2147483647"
    match {
      versioned_expr = "SRC_IPS_V1"
      config {
        src_ip_ranges = ["*"]
      }
    }
    description = "default rule"
  }
}
