class third_party::zabbix::server_service {
  service { "zabbix-java-gateway":
    ensure     => running,
    enable     => true,
    hasrestart => true,
    hasstatus  => true,
    require    => [Class["third_party::httpd::service"], Class["third_party::zabbix::server_config"]]
  } ->
  service { "zabbix-server":
    ensure     => running,
    enable     => true,
    hasrestart => true,
    hasstatus  => true,
  }
}

