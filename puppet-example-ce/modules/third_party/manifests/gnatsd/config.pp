class third_party::gnatsd::config {
  file { "/usr/local/gnatsd/gnatsd.conf":
    ensure  => "present",
    content => template("third_party/gnatsd/gnatsd.conf.erb"),
    mode    => 644,
    owner   => "root",
    group   => "root",
    require => Class["third_party::gnatsd::package"],
    notify  => Class["third_party::gnatsd::service"],
  }

  if $operatingsystemrelease =~ /6./ {

  } elsif $operatingsystemrelease =~ /7./ {
    file { "/usr/lib/systemd/gnatsd":
      ensure  => "present",
      content => template("third_party/gnatsd/gnatsd.erb"),
      mode    => 755,
      owner   => "root",
      group   => "root",
      notify  => Class["third_party::gnatsd::service"],
    } ->
    file { "/usr/lib/systemd/system/gnatsd.service":
      ensure  => "present",
      content => template("third_party/gnatsd/gnatsd.service.erb"),
      mode    => 644,
      owner   => "root",
      group   => "root",
      notify  => Class["third_party::gnatsd::service"],
    } ->
    file { "/etc/systemd/system/multi-user.target.wants/gnatsd.service":
      ensure => link,
      target => "/usr/lib/systemd/system/gnatsd.service",
    }

    exec { "gnatsd_systemctl_daemon_reload":
      command     => "systemctl daemon-reload",
      logoutput   => true,
      refreshonly => true,
      subscribe   => [File["/usr/lib/systemd/system/gnatsd.service"], File["/usr/lib/systemd/gnatsd"]]
    }
  }
}
