class multi_server::site_instance::init {
  include codenvy_user
  include third_party::jdk::install
  include third_party::haproxy::install
  #include third_party::gorouter::install
  include third_party::dnsmasq::install
  include third_party::nginx::install
  include third_party::rsyslog::install
  include multi_server::site_instance::install
  if $install_monitoring_tools == "true" {
    include third_party::zabbix::agent_install
  }
}
