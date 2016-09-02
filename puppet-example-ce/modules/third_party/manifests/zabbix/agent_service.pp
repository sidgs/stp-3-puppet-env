class third_party::zabbix::agent_service {
  service { "zabbix-agent":
    ensure     => running,
    enable     => true,
    hasrestart => true,
    hasstatus  => true,
    require    => Class["third_party::zabbix::agent_config"]
  }
}