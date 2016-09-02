class third_party::docker_distribution::service {
  service { "docker-distribution":
    ensure     => running,
    enable     => true,
    hasrestart => true,
    hasstatus  => true,
    require    => [Class["third_party::docker_distribution::config"], Class["third_party::redis::service"]]
  }
}
