class third_party::swarm::config {
  if $operatingsystemrelease =~ /6./ {

  } elsif $operatingsystemrelease =~ /7./ {
    # prepare swarm service
    file { "/usr/lib/systemd/swarm":
      ensure  => "present",
      content => template("third_party/swarm/swarm.erb"),
      mode    => 755,
      owner   => "root",
      group   => "root",
      notify  => Class["third_party::swarm::service"],
    } ->
    file { "/usr/lib/systemd/system/swarm.service":
      ensure  => "present",
      content => template("third_party/swarm/swarm.service.erb"),
      mode    => 644,
      owner   => "root",
      group   => "root",
      notify  => Class["third_party::swarm::service"],
    } ->
    file { "/etc/systemd/system/multi-user.target.wants/swarm.service":
      ensure => link,
      target => "/usr/lib/systemd/system/swarm.service",
    }

    exec { "swarm_systemctl_daemon_reload":
      command     => "systemctl daemon-reload",
      logoutput   => true,
      refreshonly => true,
      subscribe   => [File["/usr/lib/systemd/system/swarm.service"], File["/usr/lib/systemd/swarm"]]
    }
  }
}
