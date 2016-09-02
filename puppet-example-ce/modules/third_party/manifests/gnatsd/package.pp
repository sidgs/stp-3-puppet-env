class third_party::gnatsd::package {
  $gnatsd_version = "0.5.6"

  exec { "download_gnatsd":
    cwd     => "/usr/local/",
    command => "wget --user rpm-download --password tzXBvglyUgI https://install.codenvycorp.com/RPM/gnatsd-$gnatsd_version.zip",
    creates => "/usr/local/gnatsd-$gnatsd_version.zip",
    require => Class["third_party::wget::install"],
    timeout => 7200,
    notify  => Exec["extract_gnatsd"],
  }

  exec { "extract_gnatsd":
    cwd         => "/usr/local/",
    command     => "rm -rf /usr/local/gnatsd; unzip /usr/local/gnatsd-$gnatsd_version.zip",
    refreshonly => true,
    require     => [Class["third_party::unzip::install"], Exec["download_gnatsd"]],
    notify      => Class["third_party::gnatsd::service"],
  }
}