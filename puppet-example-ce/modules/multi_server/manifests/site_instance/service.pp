class multi_server::site_instance::service {
  service { "codenvy":
    ensure     => running,
    enable     => true,
    hasstatus  => true,
    hasrestart => true,
    require    => [
      Class["third_party::jdk::install"],
      Class["third_party::postfix::install"],
      Class["third_party::haproxy::service"],
      Class["multi_server::site_instance::package"]],
    subscribe  => Class["third_party::jdk::install"],
  }
}