class third_party::syslog_ng::install {
  include third_party::syslog_ng::package

  class { "third_party::syslog_ng::config":
    owner    => $owner,
    group    => $group,
    port     => $port,
    log_path => $log_path,
  }
  include third_party::syslog_ng::service
}