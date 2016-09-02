class multi_server::data_instance::configs {
# changing iptables
  file { "/etc/sysconfig/iptables":
    ensure  => "present",
    content => template("multi_server/data_instance/iptables.erb"),
    owner   => root,
    group   => root,
    mode    => "600",
    notify  => Class["third_party::iptables::service"],
    require => Class["third_party::iptables::package"]
  }

  # adding codenvy user
  third_party::pgsql::pgutils::create_user { "$pgsql_username":
    password  => "$pgsql_pass",
    #superuser => true
  } -> # adding codenvy database
  third_party::pgsql::pgutils::create_database { "$pgsql_database_name":
    dbowner => "$pgsql_username"
  }
}
