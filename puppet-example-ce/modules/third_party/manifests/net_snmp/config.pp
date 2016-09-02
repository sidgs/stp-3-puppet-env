class third_party::net_snmp::config ($snmpv3_user, $snmpv3_pw, $snmpv3_priv) {

  exec { "create_snmpv3_user":
  # for net-snmp-config to work snmpd must at least have been started once and must be stopped during execution
    command => "service snmpd restart; service snmpd stop &&   echo createUser ${snmpv3_user} MD5 ${snmpv3_pw} DES ${snmpv3_priv} >>/var/lib/net-snmp/snmpd.conf",
    unless  => "grep -q usmUser /var/lib/net-snmp/snmpd.conf",
    user    => "root",
    require => Class["third_party::net_snmp::package"],
  }

  exec { "create_snmpv3_user_config":
    command => "echo rouser ${snmpv3_user} >>/etc/snmp/snmpd.conf",
    unless  => "grep -q rouser /etc/snmp/snmpd.conf",
    user    => "root",
    require => Class["third_party::net_snmp::package"],
  }

}