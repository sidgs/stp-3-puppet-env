class third_party::zabbix::agent_install {
  include third_party::zabbix::repo
  include third_party::zabbix::agent_package

  class { "third_party::zabbix::agent_config": zabbix_server => $zabbix_server }
  include third_party::zabbix::agent_service
}