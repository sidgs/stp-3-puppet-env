class third_party::docker_distribution::config {

  file { "/usr/local/docker-distribution/config.yml":
    ensure  => "present",
    content => template("third_party/docker_distribution/config.yml.erb"),
    mode    => 644,
    owner   => "root",
    group   => "root",
    require => Class["third_party::docker_distribution::package"],
    notify  => Class["third_party::docker_distribution::service"],
  }

  file { "/usr/lib/systemd/docker-distribution":
    ensure  => "present",
    content => template("third_party/docker_distribution/docker-distribution.erb"),
    mode    => 755,
    owner   => "root",
    group   => "root",
    notify  => Class["third_party::docker_distribution::service"],
  } ->
  file { "/usr/lib/systemd/system/docker-distribution.service":
    ensure  => "present",
    content => template("third_party/docker_distribution/docker-distribution.service.erb"),
    mode    => 644,
    owner   => "root",
    group   => "root",
    notify  => Class["third_party::docker_distribution::service"],
    selinux_ignore_defaults => true
  } ->
  file { "/etc/systemd/system/multi-user.target.wants/docker-distribution.service":
    ensure => link,
    target => "/usr/lib/systemd/system/docker-distribution.service",
  }

  exec { "docker_distribution_systemctl_daemon_reload":
    command     => "systemctl daemon-reload",
    logoutput   => true,
    refreshonly => true,
    subscribe   => [File["/usr/lib/systemd/system/docker-distribution.service"], File["/usr/lib/systemd/docker-distribution"]]
  }
}

