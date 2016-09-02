class third_party::net_snmp::install {
  include third_party::net_snmp::package
  class { "third_party::net_snmp::config":
    snmpv3_user => $snmpv3_user,
    snmpv3_pw   => $snmpv3_pw,
    snmpv3_priv => $snmpv3_priv
  }
  include third_party::net_snmp::service
}