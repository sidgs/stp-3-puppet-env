class multi_server::data_instance::init {
  $includes = [
    "third_party::pgsql::install",
    "third_party::openldap_servers::install",
    "third_party::mongo::install",
    "third_party::rsyslog::install",
    "third_party::docker_distribution::install",
    "multi_server::data_instance::install"]

  Class['third_party::pgsql::service'] -> Class['third_party::openldap_servers::service'] -> Class['third_party::mongo::service']

  include $includes
  if $install_monitoring_tools == "true" {
    include third_party::zabbix::agent_install
  }
}
