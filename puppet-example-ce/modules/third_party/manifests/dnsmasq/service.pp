class third_party::dnsmasq::service {
  service { "dnsmasq":
    ensure     => running,
    enable     => true,
    hasrestart => true,
    hasstatus  => true,
    require    => Class["third_party::dnsmasq::config"],
  }
}
