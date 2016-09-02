class third_party::zabbix::server_package {
  package { "zabbix-server-mysql":
    provider => yum,
    ensure   => absent,
  } ->
  package { "zabbix-server-pgsql":
    ensure  => "3.0.0-1.el7",
    require => [Class["third_party::zabbix::repo"], Class["third_party::httpd::install"]],
  } ->

  package { "zabbix-web-pgsql":
    ensure  => "3.0.0-1.el7",
    require => Package["zabbix-server-pgsql"],
  } ->

  package { "zabbix-java-gateway":
    ensure  => "3.0.0-1.el7",
    require => Package["zabbix-web-pgsql"]
  } ->

  package { "gzip":
    ensure => installed,
  }  ->
  package { "zabbix-web-mysql":
    provider          => yum,
    ensure            => absent,
    notify => Class["third_party::httpd::service"]
  }
}
