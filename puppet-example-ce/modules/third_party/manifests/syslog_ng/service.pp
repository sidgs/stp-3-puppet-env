class third_party::syslog_ng::service {
  service { "syslog-ng":
    ensure     => running,
    enable     => true,
    hasstatus  => true,
    hasrestart => true,
    require    => Class["third_party::syslog_ng::config"]
  }
}