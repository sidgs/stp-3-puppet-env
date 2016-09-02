class third_party::gorouter::service {
  service { "gorouter":
    ensure     => running,
    enable     => true,
    hasrestart => true,
    hasstatus  => true,
    require    => Class["third_party::gorouter::config"]
  }
}
