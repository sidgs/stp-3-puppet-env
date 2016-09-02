class multi_server::machine_instance::configs {
  $config_dirs = [
    "/home/$codenvy_user/archives/",
    "/home/$codenvy_user/codenvy-data/",
    "/home/$codenvy_user/codenvy-data/che-machines",
  ]

# creating folders
  file { $config_dirs:
    ensure  => "directory",
    owner   => $codenvy_user,
    group   => $codenvy_user,
    mode    => "755",
    require => Class["codenvy_user"]
  }

# changing iptables
  file { "/etc/sysconfig/iptables":
    ensure  => "present",
    content => template("multi_server/machine_instance/iptables.erb"),
    owner   => root,
    group   => root,
    mode    => "600",
    notify  => Class["third_party::iptables::service"],
    require => Class["third_party::iptables::package"]
  }

  third_party::sysctl::sysctl { "net.ipv4.ip_forward": value => "1" }

  third_party::limits::limits { 'root_nofile':
    ensure     => present,
    user       => "root",
    limit_type => 'nofile',
    hard       => 163840,
    soft       => 163840,
  }

  third_party::limits::limits { 'root_nproc':
    ensure     => present,
    user       => "root",
    limit_type => 'nproc',
    hard       => 163840,
    soft       => 163840,
  }
}
