class multi_server::analytics_instance::service {
  service { "codenvy":
    ensure     => running,
    enable     => true,
    hasstatus  => true,
    hasrestart => true,
    require    => [
      Class["third_party::jdk::install"],
      Class["third_party::postfix::install"],
      Class["third_party::syslog_ng::service"],
      Class["third_party::mongo::install"],
      Class["third_party::mongo::service"],
      Class["multi_server::analytics_instance::package"]],
    subscribe  => Class["third_party::jdk::install"],
  }
}