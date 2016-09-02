class third_party::rsyslog::config ($analytics_fix) {
  file { "/etc/rsyslog.conf":
    ensure  => "present",
    content => template("third_party/rsyslog/rsyslog.conf.erb"),
    owner   => root,
    group   => root,
    mode    => "644",
    notify  => Class["third_party::rsyslog::service"],
    require => Class["third_party::rsyslog::package"]
  }
}