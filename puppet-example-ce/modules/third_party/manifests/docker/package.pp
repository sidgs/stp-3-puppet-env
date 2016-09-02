class third_party::docker::package {

  if $docker_storage_path == undef {
    $docker_storage_path = "/var/lib/docker"
  }

  package { "docker":
    ensure  => "absent",
    notify  => Exec["purge_docker_storage"]
  } ->
  package { "docker-selinux":
    ensure => "absent",
  } ->
  package { "docker-engine":
    ensure  => "1.11.1-1.el7.centos",
    require => Class["third_party::docker::repo"]
  }

  # purge docker storage tobe able to update from 1.8.x to 1.11.x
  exec { "purge_docker_storage":
    command     => "rm -rf $docker_storage_path/*",
    refreshonly => true,
  }
}
