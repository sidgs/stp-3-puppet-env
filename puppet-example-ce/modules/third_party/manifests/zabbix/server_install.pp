class third_party::zabbix::server_install {
  # zabbix deps
  include third_party::httpd::install

  include third_party::zabbix::repo
  include third_party::zabbix::server_package

  class { "third_party::zabbix::server_config":
    zabbix_db_pass         => $zabbix_db_pass,
    zabbix_time_zone       => $zabbix_time_zone,
    zabbix_entry_point_url => $zabbix_entry_point_url
  }
  include third_party::zabbix::server_service

  class { "third_party::zabbix::server_post_installation_config":
    jmx_username => $jmx_username,
    jmx_password => $jmx_password
  }
}
