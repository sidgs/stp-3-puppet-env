class third_party::gorouter::config {
  file { "/usr/local/gorouter/gorouter.conf":
    ensure  => "present",
    content => template("third_party/gorouter/gorouter.conf.erb"),
    mode    => 644,
    owner   => "root",
    group   => "root",
    require => Class["third_party::gorouter::package"],
    notify  => Class["third_party::gorouter::service"],
  }

  if $operatingsystemrelease =~ /6./ {

  } elsif $operatingsystemrelease =~ /7./ {
    file { "/usr/lib/systemd/gorouter":
      ensure  => "present",
      content => template("third_party/gorouter/gorouter.erb"),
      mode    => 755,
      owner   => "root",
      group   => "root",
      notify  => Class["third_party::gorouter::service"],
      require => Class["third_party::gorouter::package"],
    } ->
    file { "/usr/lib/systemd/system/gorouter.service":
      ensure  => "present",
      content => template("third_party/gorouter/gorouter.service.erb"),
      mode    => 644,
      owner   => "root",
      group   => "root",
      notify  => Class["third_party::gorouter::service"],
    } ->
    file { "/etc/systemd/system/multi-user.target.wants/gorouter.service":
      ensure => link,
      target => "/usr/lib/systemd/system/gorouter.service",
    }

    exec { "gorouter_systemctl_daemon_reload":
      command     => "systemctl daemon-reload",
      logoutput   => true,
      refreshonly => true,
      subscribe   => [File["/usr/lib/systemd/system/gorouter.service"], File["/usr/lib/systemd/gorouter"]]
    }
  }
}
