class multi_server::analytics_instance::init {
  include codenvy_user
  include third_party::jdk::install
  include third_party::syslog_ng::install

  class { "third_party::mongo::install": is_analytics => "true" }

  class { "third_party::rsyslog::install": is_analytics => "true" }
  include third_party::pgsql::install
  include multi_server::analytics_instance::install

  if $install_monitoring_tools == "true" {
    include third_party::zabbix::server_install
    include third_party::zabbix::agent_install
  }
}
