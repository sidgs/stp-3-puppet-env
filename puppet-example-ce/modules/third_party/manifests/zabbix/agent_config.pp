class third_party::zabbix::agent_config ($zabbix_server) {
  file { "/etc/zabbix/zabbix_agentd.conf":
    ensure  => present,
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    content => template("third_party/zabbix/zabbix_agentd.conf.erb"),
    require => Class["third_party::zabbix::agent_package"],
    notify  => Class["third_party::zabbix::agent_service"]
  }
  if tagged("third_party::docker::service") {
    exec { "adding_zabbix_user_to_docker_group":
      unless      => "grep -q 'docker\\S*zabbix' /etc/group",
      command     => "usermod -aG docker zabbix",
      require     => Class["third_party::docker::service"],
      refreshonly => true,
      subscribe   => File["/etc/zabbix/zabbix_agentd.conf"]
    }
  }
}
