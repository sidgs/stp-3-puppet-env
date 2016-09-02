class third_party::gnatsd::service {
  service { "gnatsd":
    ensure     => running,
    enable     => true,
    hasrestart => true,
    hasstatus  => true,
    require    => Class["third_party::gnatsd::config"]
  }
}
