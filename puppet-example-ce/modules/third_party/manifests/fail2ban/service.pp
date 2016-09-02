class third_party::fail2ban::service {
  service { "fail2ban":
    ensure     => running,
    enable     => true,
    hasrestart => true,
    hasstatus  => true,
    require    => [Class["third_party::fail2ban::config"], Class["third_party::iptables::service"]],
    subscribe  => Class["third_party::iptables::service"]
  }
}
