class multi_server::ims_instance::configs {
  # changing iptables
  file { "/etc/sysconfig/iptables":
    ensure  => "present",
    content => template("multi_server/ims_instance/iptables.erb"),
    owner   => root,
    group   => root,
    mode    => "600",
    notify  => Class["third_party::iptables::service"],
    require => Class["third_party::iptables::package"]
  }

  #clean up old puppet reports.
  tidy { '/var/lib/puppet/reports':
    age     => "3w",
    recurse => true,
  }
}
