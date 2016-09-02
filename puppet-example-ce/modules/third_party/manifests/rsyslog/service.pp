class third_party::rsyslog::service {
  service { "rsyslog":
    ensure     => running,
    enable     => true,
    hasrestart => true,
    hasstatus  => true,
    require    => Class["third_party::rsyslog::config"]
  }
}