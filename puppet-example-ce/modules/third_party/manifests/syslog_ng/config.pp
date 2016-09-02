class third_party::syslog_ng::config ($owner, $group, $port, $log_path) {
  file { "/etc/syslog-ng/syslog-ng.conf":
    ensure  => "present",
    content => template("third_party/syslog_ng/syslog-ng.conf.erb"),
    owner   => root,
    group   => root,
    mode    => "600",
    require => Class["third_party::syslog_ng::package"],
    notify  => Class["third_party::syslog_ng::service"]
  }
}