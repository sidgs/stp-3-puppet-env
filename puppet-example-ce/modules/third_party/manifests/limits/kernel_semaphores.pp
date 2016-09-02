class third_party::limits::kernel_semaphores {
  $limits = "250 32000 100 1024"

# set limits permanently
  file { "/etc/sysctl.conf":
    ensure  => "present",
    content => template("third_party/limits/sysctl.conf.erb"),
    owner   => 'root',
    group   => 'root',
    mode    => '644',
    notify  => Exec["reload_sysctl_confing"]
  }

  exec { "reload_sysctl_confing":
    command     => "sysctl -p",
    refreshonly => true,
    logoutput   => true
  }
}