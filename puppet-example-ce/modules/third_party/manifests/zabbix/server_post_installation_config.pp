class third_party::zabbix::server_post_installation_config ($jmx_username, $jmx_password) {
  file { "/etc/zabbix/importData":
    ensure  => present,
    owner   => 'root',
    group   => 'root',
    mode    => '0664',
    content => template("third_party/zabbix/zabbix_configs.erb"),
    require => Class["third_party::zabbix::server_service"],
    notify  => Exec["configureZabbixServer"]
  } ->
  file { "/etc/zabbix/configureZabbixServer.sh":
    ensure  => present,
    owner   => 'root',
    group   => 'root',
    mode    => '0755',
    content => template("third_party/zabbix/configureZabbixServer.sh.erb"),
    notify  => Exec["configureZabbixServer"]
  } ->
  exec { "configureZabbixServer":
    provider    => shell,
    timeout  => 600,
    command     => "/etc/zabbix/configureZabbixServer.sh",
    logoutput   => true,
    refreshonly => true
  }
}
