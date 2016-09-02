class third_party::zabbix::agent_package {
  package { "zabbix-agent":
    ensure  => "3.0.0-1.el7",
    require => Class["third_party::zabbix::repo"]
  }
}