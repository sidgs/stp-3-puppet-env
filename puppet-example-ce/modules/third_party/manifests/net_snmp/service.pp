class third_party::net_snmp::service {
  service { "snmpd":
    ensure     => running,
    enable     => true,
    hasrestart => true,
    hasstatus  => true,
    require    => Class["third_party::net_snmp::config"],
  }
}