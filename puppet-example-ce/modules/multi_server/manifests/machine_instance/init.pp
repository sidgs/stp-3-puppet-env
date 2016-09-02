class multi_server::machine_instance::init {
  include codenvy_user
  include third_party::docker::install
  include third_party::rsyslog::install
  include third_party::rsync::install
  include multi_server::machine_instance::install
  if $install_monitoring_tools == "true" {
    include third_party::zabbix::agent_install
    include third_party::sysdig::install
  }
}
