class multi_server::site_instance::configs {
  if $codenvy_server_xmx == undef {
    $xmx = "1024"
  } else {
    $xmx = $codenvy_server_xmx
  }

  $config_dirs = [
    "/home/$codenvy_user/codenvy-tomcat/",
    "/home/$codenvy_user/archives/",
    "/home/$codenvy_user/codenvy-data/",
    "/home/$codenvy_user/codenvy-data/logs",
    "/home/$codenvy_user/codenvy-data/conf",
    "/home/$codenvy_user/codenvy-data/conf/logback",
  ]

  # changing iptables
  file { "/etc/sysconfig/iptables":
    ensure  => "present",
    content => template("multi_server/site_instance/iptables.erb"),
    owner   => root,
    group   => root,
    mode    => "600",
    notify  => Class["third_party::iptables::service"],
    require => Class["third_party::iptables::package"]
  }

  # creating folders
  file { $config_dirs:
    ensure  => "directory",
    owner   => $codenvy_user,
    group   => $codenvy_user,
    mode    => "755",
    require => Class["codenvy_user"]
  }

  # creating .bashrc
  file { "/home/$codenvy_user/.bashrc":
    ensure  => "present",
    content => template("multi_server/site_instance/bashrc.erb"),
    owner   => $codenvy_user,
    group   => $codenvy_user,
    mode    => "644",
    require => Class["codenvy_user"],
    notify  => Class["multi_server::site_instance::service"],
  }

  # creating logback-additional-appenders.xml
  file { "/home/$codenvy_user/codenvy-data/conf/logback/logback-additional-appenders.xml":
    ensure  => "present",
    content => template("multi_server/site_instance/logback-additional-appenders.xml.erb"),
    owner   => $codenvy_user,
    group   => $codenvy_user,
    mode    => "644",
    require => File[$config_dirs],
    notify  => Class["multi_server::site_instance::service"],
  }

  # creating general.properties
  file { "/home/$codenvy_user/codenvy-data/conf/general.properties":
    ensure  => "present",
    content => template("multi_server/site_instance/general.properties.erb"),
    owner   => $codenvy_user,
    group   => $codenvy_user,
    mode    => "644",
    require => File[$config_dirs],
    notify  => Class["multi_server::site_instance::service"],
  }

  # creating everrest.properties
  file { "/home/$codenvy_user/codenvy-data/conf/everrest.properties":
    ensure  => "present",
    content => template("multi_server/site_instance/everrest.properties.erb"),
    owner   => $codenvy_user,
    group   => $codenvy_user,
    mode    => "644",
    require => File[$config_dirs],
    notify  => Class["multi_server::site_instance::service"],
  }

  # prepare site tomcat service
  file { "/usr/lib/systemd/codenvy":
    ensure  => "present",
    content => template("multi_server/site_instance/codenvy.el7.erb"),
    mode    => "755",
    owner   => "root",
    group   => "root",
    notify  => Class["multi_server::site_instance::service"],
  } ->
  file { "/usr/lib/systemd/system/codenvy.service":
    ensure  => "present",
    content => template("multi_server/site_instance/codenvy.service.erb"),
    mode    => "644",
    owner   => "root",
    group   => "root",
    notify  => Class["multi_server::site_instance::service"],
  } ->
  file { "/etc/systemd/system/multi-user.target.wants/codenvy.service":
    ensure => link,
    target => "/usr/lib/systemd/system/codenvy.service",
  }

  # JMX
  file { "/home/$codenvy_user/jmxremote.access":
    ensure  => "present",
    content => "$jmx_username readwrite",
    mode    => "644",
    owner   => $codenvy_user,
    group   => $codenvy_user,
    notify  => Class["multi_server::site_instance::service"],
  }

  file { "/home/$codenvy_user/jmxremote.password":
    ensure  => "present",
    content => "$jmx_username $jmx_password",
    mode    => "644",
    owner   => $codenvy_user,
    group   => $codenvy_user,
    notify  => Class["multi_server::site_instance::service"],
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
