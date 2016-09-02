class third_party::swarm::package {
  $swarm_version = "v1.2.3"
  exec { "download_swarm":
    cwd     => "/usr/local/",
    command => "wget --user rpm-download --password tzXBvglyUgI https://install.codenvycorp.com/RPM/swarm-$swarm_version.zip",
    creates => "/usr/local/swarm-$swarm_version.zip",
    require => Class["third_party::wget::install"],
    timeout => 7200,
    notify  => Exec["extract_swarm"],
  }

  exec { "extract_swarm":
    cwd         => "/usr/local/",
    command     => "rm -rf /usr/local/swarm/bin; unzip /usr/local/swarm-$swarm_version.zip",
    refreshonly => true,
    require     => [Class["third_party::unzip::install"], Exec["download_swarm"]],
    notify      => Class["third_party::swarm::service"],
  }
}
