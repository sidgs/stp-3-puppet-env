class third_party::puppet::config {
  file { "/etc/puppet/check_state.sh":
    ensure  => "present",
    content => template("third_party/puppet/check_state.sh.erb"),
    owner   => root,
    group   => root,
    mode    => 755,
    require => Class["third_party::puppet::package"]
  }

  cron { "check_puppet_state":
    command => "/etc/puppet/check_state.sh",
    minute  => "7",
    user    => root,
    require => File["/etc/puppet/check_state.sh"],
  }

  #clean up puppet reports.
  tidy { "/var/lib/puppet/reports/":
    age     => "2w",
    recurse => true,
    backup  => false,
  }
}
