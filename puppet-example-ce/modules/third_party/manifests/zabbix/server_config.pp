class third_party::zabbix::server_config ($zabbix_db_pass, $zabbix_time_zone, $zabbix_entry_point_url) {
  file { "/etc/zabbix/zabbix_server.conf":
    ensure  => present,
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    content => template("third_party/zabbix/zabbix_server.conf.erb"),
    require => Class["third_party::zabbix::server_package"],
    notify  => Class["third_party::zabbix::server_service"]
  }

  file { "/etc/zabbix/web/zabbix.conf.php":
    ensure  => present,
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    content => template("third_party/zabbix/zabbix.conf.php.erb"),
    require => Class["third_party::zabbix::server_package"],
    notify  => Class["third_party::zabbix::server_service"]
  }

  file { "/etc/httpd/conf.d/zabbix.conf":
    ensure  => present,
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    content => template("third_party/zabbix/zabbix.conf.el7.erb"),
    require => Class["third_party::zabbix::server_package"],
    notify  => Class["third_party::httpd::service"]
  }

  file { "/etc/zabbix/zabbix_java_gateway.conf":
    ensure  => present,
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    content => template("third_party/zabbix/zabbix_java_gateway.conf.erb"),
    require => Class["third_party::zabbix::server_package"],
    notify  => Class["third_party::zabbix::server_service"]
  }

  exec { "disable_listen_80_port":
    cwd       => "/etc/httpd/conf",
    onlyif    => "test `grep 'Listen 80' 'httpd.conf' | grep -v '^#' | wc -l` -ne 0",
    command   => "sed -e '/Listen 80/ s/^#*/#/' -i httpd.conf",
    require   => Class["third_party::httpd::install"],
    notify    => Class["third_party::httpd::service"],
    logoutput => true
  }

  # create zabbix user
  third_party::pgsql::pgutils::create_user { "zabbix":
    password  => "$zabbix_db_pass",
    #superuser => false,
  } ->
    # adding database for zabbix
  third_party::pgsql::pgutils::create_database { "zabbix":
    dbowner => "zabbix",
  } ~>
  exec { "import_base_schema":
    provider    => shell,
    command     => "zcat `/bin/rpm -ql zabbix-server-pgsql | grep 'create.sql.gz'` | psql -q -U zabbix -d zabbix",
    timeout     => 600,
    logoutput   => true,
    refreshonly => true
  }
}
