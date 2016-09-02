class third_party::syslog_ng::package {
  package { "syslog-ng":
    ensure  => "installed",
    require => Class["third_party::epel::install"]
  }
}