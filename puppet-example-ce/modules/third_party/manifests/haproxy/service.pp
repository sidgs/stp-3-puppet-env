class third_party::haproxy::service {
  service { "haproxy":
    ensure     => running,
    enable     => true,
    hasrestart => true,
    hasstatus  => true,
    require    => [Class["third_party::haproxy::config"],Class["third_party::rsyslog::service"]]
  }
}