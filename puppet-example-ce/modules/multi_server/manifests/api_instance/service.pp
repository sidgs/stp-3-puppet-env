class multi_server::api_instance::service {
  service { "codenvy":
    ensure     => running,
    enable     => true,
    hasstatus  => true,
    hasrestart => true,
    require    => [
      Class["third_party::jdk::install"],
      Class["third_party::postfix::install"],
      Class["third_party::nmap::install"],
      Class["third_party::mongo::package_shell"],
      Class["multi_server::api_instance::package"]],
    subscribe  => Class["third_party::jdk::install"],
  }
}