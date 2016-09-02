class third_party::docker::config {

  if $docker_storage_type == undef {
    $docker_storage_type = "loopback"
  }

  if $docker_storage_path == undef {
    $docker_storage_path = "/var/lib/docker"
  }

  group { "docker": ensure => "present", } ->
  exec { "adding_user_to_docker_group":
    unless  => "grep -q 'docker\\S*$codenvy_user' /etc/group",
    command => "usermod -aG docker $codenvy_user",
    require => [User[$codenvy_user], Class["third_party::docker::package"]],
    notify  => Class["third_party::docker::service"]
  } ->
  file { "/etc/sysconfig/docker":
    owner   => "root",
    group   => "root",
    mode    => 644,
    content => template("third_party/docker/docker.erb"),
    require => Class["third_party::docker::package"],
    notify  => Class["third_party::docker::service"],
  } ->
  file { "/etc/sysconfig/docker-storage":
    owner   => "root",
    group   => "root",
    mode    => 644,
    content => template("third_party/docker/docker-storage.erb"),
    require => Class["third_party::docker::package" ],
    notify  => Class["third_party::docker::service"],
  } ->
  file { "/etc/sysconfig/docker-network":
    owner   => "root",
    group   => "root",
    mode    => 644,
    content => template("third_party/docker/docker-network.erb"),
    require => Class["third_party::docker::package"],
    notify  => Class["third_party::docker::service"],
  } ->
  file { "/etc/systemd/system/docker.service.d":
    ensure  => "directory",
    owner   => "root",
    group   => "root",
    mode    => "755",
    selinux_ignore_defaults => true,
  } ->
  file { "/etc/systemd/system/docker.service.d/docker.conf":
    owner   => "root",
    group   => "root",
    mode    => 644,
    content => template("third_party/docker/docker.conf.erb"),
    require => Class["third_party::docker::package"],
    notify  => Class["third_party::docker::service"],
    selinux_ignore_defaults => true,
  }
  exec { "reload_systemctl_confing_after_adding_custom_docker_conf":
    command     => "systemctl daemon-reload",
    logoutput   => true,
    refreshonly => true,
    subscribe   => File["/etc/systemd/system/docker.service.d/docker.conf"]
  }
}
