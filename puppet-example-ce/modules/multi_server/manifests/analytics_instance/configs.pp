class multi_server::analytics_instance::configs {
  if $codenvy_server_xmx == undef {
    $xmx = "1024"
  } else {
    $xmx = $codenvy_server_xmx
  }
  $config_dirs = [
    "/home/$codenvy_user/codenvy-tomcat/",
    "/home/$codenvy_user/archives/",
    "$log_path",
    "/home/$codenvy_user/analytics_conf/",
    "/home/$codenvy_user/analytics_data",
  ]

  # creating folders
  file { $config_dirs:
    ensure  => "directory",
    owner   => $codenvy_user,
    group   => $codenvy_user,
    mode    => "755",
    require => Class["codenvy_user"]
  }

  # changing iptables
  file { "/etc/sysconfig/iptables":
    ensure  => "present",
    content => template("multi_server/analytics_instance/iptables.erb"),
    owner   => root,
    group   => root,
    mode    => "600",
    notify  => Class["third_party::iptables::service"],
    require => Class["third_party::iptables::package"]
  }

  # creating .bashrc
  file { "/home/$codenvy_user/.bashrc":
    ensure  => "present",
    content => template("multi_server/analytics_instance/bashrc.erb"),
    owner   => $codenvy_user,
    group   => $codenvy_user,
    mode    => "644",
    require => Class["codenvy_user"],
    notify  => Class["multi_server::analytics_instance::service"],
  }

  # prepare analytics tomcat service
  file { "/usr/lib/systemd/codenvy":
    ensure  => "present",
    content => template("multi_server/analytics_instance/codenvy.el7.erb"),
    mode    => "755",
    owner   => "root",
    group   => "root",
    notify  => Class["multi_server::analytics_instance::service"],
  } ->
  file { "/usr/lib/systemd/system/codenvy.service":
    ensure  => "present",
    content => template("multi_server/analytics_instance/codenvy.service.erb"),
    mode    => "644",
    owner   => "root",
    group   => "root",
    notify  => Class["multi_server::analytics_instance::service"],
  } ->
  file { "/etc/systemd/system/multi-user.target.wants/codenvy.service":
    ensure => link,
    target => "/usr/lib/systemd/system/codenvy.service",
  }

  # creating logback-smtp-appender.xml
  file { "/home/$codenvy_user/analytics_conf/logback-smtp-appender.xml":
    ensure  => "present",
    content => template("multi_server/analytics_instance/logback-smtp-appender.xml.erb"),
    owner   => $codenvy_user,
    group   => $codenvy_user,
    mode    => "644",
    require => Class["codenvy_user"],
    notify  => Class["multi_server::analytics_instance::service"],
  }

  # creating analytics.properties
  file { "/home/$codenvy_user/analytics_conf/analytics.properties":
    ensure  => "present",
    content => template("multi_server/analytics_instance/analytics.properties.erb"),
    owner   => $codenvy_user,
    group   => $codenvy_user,
    mode    => "644",
    require => Class["codenvy_user"],
    notify  => Class["multi_server::analytics_instance::service"],
  }

  third_party::sysctl::sysctl { "net.core.rmem_max": value => "67108864" }

  # JMX
  file { "/home/$codenvy_user/jmxremote.access":
    ensure  => "present",
    content => "$jmx_username readwrite",
    mode    => "644",
    owner   => $codenvy_user,
    group   => $codenvy_user,
    notify  => Class["multi_server::analytics_instance::service"],
  }

  file { "/home/$codenvy_user/jmxremote.password":
    ensure  => "present",
    content => "$jmx_username $jmx_password",
    mode    => "644",
    owner   => $codenvy_user,
    group   => $codenvy_user,
    notify  => Class["multi_server::analytics_instance::service"],
  }

  third_party::limits::limits { 'codenvy_nofile':
    ensure     => present,
    user       => $codenvy_user,
    limit_type => 'nofile',
    hard       => 16384,
    soft       => 16384,
  }

  third_party::limits::limits { 'codenvy_nproc':
    ensure     => present,
    user       => $codenvy_user,
    limit_type => 'nproc',
    hard       => 16384,
    soft       => 16384,
  }
}
