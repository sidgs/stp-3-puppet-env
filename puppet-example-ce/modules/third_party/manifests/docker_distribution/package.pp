class third_party::docker_distribution::package {
  $docker_distribution_version = "v2.3.1"

  package { "librados2":
    ensure => installed
  } ->
  exec { "download_docker_distribution":
    cwd     => "/usr/local/",
    command => "wget --user rpm-download --password tzXBvglyUgI https://install.codenvycorp.com/RPM/docker-distribution-$docker_distribution_version.zip",
    creates => "/usr/local/docker-distribution-$docker_distribution_version.zip",
    require => [Class["third_party::wget::install"], Class["third_party::redis::install"]],
    timeout => 7200,
    notify  => Exec["extract_docker_distribution"],
  }

  exec { "extract_docker_distribution":
    cwd         => "/usr/local/",
    command     => "rm -rf /usr/local/docker-distribution; unzip /usr/local/docker-distribution-$docker_distribution_version.zip",
    refreshonly => true,
    require     => [Class["third_party::unzip::install"], Exec["download_docker_distribution"]],
    notify      => Class["third_party::docker_distribution::service"],
  }
}
