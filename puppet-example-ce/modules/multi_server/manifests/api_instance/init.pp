class multi_server::api_instance::init {
  include codenvy_user
  include third_party::jdk::install
  include third_party::rsyslog::install
  include third_party::mongo::package_shell
  include third_party::swarm::install
  include third_party::rsync::install
  include multi_server::api_instance::install
  if $install_monitoring_tools == "true" {
    include third_party::zabbix::agent_install
  }
}
