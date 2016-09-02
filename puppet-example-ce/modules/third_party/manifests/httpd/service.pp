class third_party::httpd::service {
  service { "httpd":
    ensure     => running,
    enable     => true,
    hasrestart => true,
    hasstatus  => true,
    require    => Class["third_party::httpd::package"]
  }
}