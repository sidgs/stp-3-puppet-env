class third_party::iptables::service {
  service { "iptables":
    ensure     => running,
    enable     => true,
    hasrestart => true,
    hasstatus  => true,
    require    => Class["third_party::iptables::package"],
  }
}