class third_party::gorouter::package {
  $gorouter_version = "339136b7238f300be1ea4648221f0fc955e7e9c8"

  exec { "download_gorouter":
    cwd     => "/usr/local/",
    command => "wget --user rpm-download --password tzXBvglyUgI https://install.codenvycorp.com/RPM/gorouter-$gorouter_version.zip",
    creates => "/usr/local/gorouter-$gorouter_version.zip",
    # added dependency for gnats service to make sure that gnatsd started before
    # gorouter will be installed
    require => [Class["third_party::wget::install"], Class["third_party::gnatsd::service"]],
    timeout => 7200,
    notify  => Exec["extract_gorouter"],
  }

  exec { "extract_gorouter":
    cwd         => "/usr/local/",
    command     => "rm -rf /usr/local/gorouter; unzip /usr/local/gorouter-$gorouter_version.zip",
    refreshonly => true,
    require     => [Class["third_party::unzip::install"], Exec["download_gorouter"]],
    notify      => Class["third_party::gorouter::service"],
  }
}
