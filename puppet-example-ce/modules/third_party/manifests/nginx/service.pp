class third_party::nginx::service {
  service { "nginx":
    ensure     => running,
    enable     => true,
    hasrestart => true,
    hasstatus  => true,
    require    => Class["third_party::nginx::config"],
  }
}