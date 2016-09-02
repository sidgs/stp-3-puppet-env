class third_party::jq::install {
  exec { "download_jq":
    cwd     => "/usr/bin/",
    command => "wget --user rpm-download --password tzXBvglyUgI https://install.codenvycorp.com/RPM/jq",
    creates => "/usr/bin/jq",
    require => Class["third_party::wget::install"],
    timeout => 3600,
    notify  => Exec["set_permissions_for_jq"]
  } ->
  exec { "set_permissions_for_jq":
    cwd         => "/usr/bin/",
    command     => "chmod +x /usr/bin/jq",
    refreshonly => true
  }
}