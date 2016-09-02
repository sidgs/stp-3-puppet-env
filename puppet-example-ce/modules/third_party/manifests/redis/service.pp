class third_party::redis::service {
  service { "redis":
    ensure     => running,
    enable     => true,
    hasrestart => true,
    hasstatus  => true,
    require    => Class["third_party::redis::config"],
  }
}