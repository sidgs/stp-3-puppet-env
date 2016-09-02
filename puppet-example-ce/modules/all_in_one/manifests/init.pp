class all_in_one {
  $includes = [
    "codenvy_user",
    "third_party::jdk::install",
    "third_party::openldap_servers::install",
    "third_party::mongo::install",
    "third_party::haproxy::install",
    "third_party::docker::install",
    "third_party::rsyslog::install",
    "third_party::pgsql::install",
    "third_party::swarm::install",
    "third_party::docker_distribution::install",
    #"third_party::gorouter::install",
    "third_party::nginx::install",
    "third_party::rsync::install",
    "third_party::dnsmasq::install",
    "all_in_one::install",
  ]

  include $includes

  if $install_monitoring_tools == "true" {
    include third_party::zabbix::server_install
    include third_party::zabbix::agent_install
    include third_party::sysdig::install
  }
}
