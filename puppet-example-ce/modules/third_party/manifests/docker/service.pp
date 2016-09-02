class third_party::docker::service {
  service { "docker":
    ensure     => running,
    enable     => true,
    hasrestart => true,
    hasstatus  => true,
    require    => Class["third_party::docker::config"],
    subscribe  => Class["third_party::iptables::service"]
  }
}
