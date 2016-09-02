class multi_server::api_instance::configs {
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
    "/home/$codenvy_user/codenvy-data/data",
    "/home/$codenvy_user/codenvy-data/che-machines-logs",
    "/home/$codenvy_user/codenvy-data/data/fs",
    "/home/$codenvy_user/codenvy-data/data/tmp_fs",
  ]

  # changing iptables
  file { "/etc/sysconfig/iptables":
    ensure  => "present",
    content => template("multi_server/api_instance/iptables.erb"),
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
    content => template("multi_server/api_instance/bashrc.erb"),
    owner   => $codenvy_user,
    group   => $codenvy_user,
    mode    => "644",
    require => Class["codenvy_user"],
    notify  => Class["multi_server::api_instance::service"],
  }

  # prepare api tomcat service
  file { "/usr/lib/systemd/codenvy":
    ensure  => "present",
    content => template("multi_server/api_instance/codenvy.el7.erb"),
    mode    => "755",
    owner   => "root",
    group   => "root",
    notify  => Class["multi_server::api_instance::service"],
  } ->
  file { "/usr/lib/systemd/system/codenvy.service":
    ensure  => "present",
    content => template("multi_server/api_instance/codenvy.service.erb"),
    mode    => "644",
    owner   => "root",
    group   => "root",
    notify  => Class["multi_server::api_instance::service"],
  } ->
  file { "/etc/systemd/system/multi-user.target.wants/codenvy.service":
    ensure => link,
    target => "/usr/lib/systemd/system/codenvy.service",
  }

  # creating factory.properties
  file { "/home/$codenvy_user/codenvy-data/conf/factory.properties":
    ensure  => "present",
    content => template("multi_server/api_instance/factory.properties.erb"),
    owner   => $codenvy_user,
    group   => $codenvy_user,
    mode    => "644",
    require => File[$config_dirs],
    notify  => Class["multi_server::api_instance::service"],
  }

  # creating general.properties
  file { "/home/$codenvy_user/codenvy-data/conf/general.properties":
    ensure  => "present",
    content => template("multi_server/api_instance/general.properties.erb"),
    owner   => $codenvy_user,
    group   => $codenvy_user,
    mode    => "644",
    require => File[$config_dirs],
    notify  => Class["multi_server::api_instance::service"],
  }

  # creating mongo.properties
  file { "/home/$codenvy_user/codenvy-data/conf/mongo.properties":
    ensure  => "present",
    content => template("multi_server/api_instance/mongo.properties.erb"),
    owner   => $codenvy_user,
    group   => $codenvy_user,
    mode    => "644",
    require => File[$config_dirs],
    notify  => Class["multi_server::api_instance::service"],
  }

  # creating ldap.properties
  file { "/home/$codenvy_user/codenvy-data/conf/ldap.properties":
    ensure  => "present",
    content => template("multi_server/api_instance/ldap.properties.erb"),
    owner   => $codenvy_user,
    group   => $codenvy_user,
    mode    => "644",
    require => File[$config_dirs],
    notify  => Class["multi_server::api_instance::service"],
  }

  # creating email-connection.properties
  file { "/home/$codenvy_user/codenvy-data/conf/email-connection.properties":
    ensure  => "present",
    content => template("multi_server/api_instance/email-connection.properties.erb"),
    owner   => $codenvy_user,
    group   => $codenvy_user,
    mode    => "644",
    require => File[$config_dirs],
    notify  => Class["multi_server::api_instance::service"],
  }

  # creating email.properties
  file { "/home/$codenvy_user/codenvy-data/conf/email.properties":
    ensure  => "present",
    content => template("multi_server/api_instance/email.properties.erb"),
    owner   => $codenvy_user,
    group   => $codenvy_user,
    mode    => "644",
    require => File[$config_dirs],
    notify  => Class["multi_server::api_instance::service"],
  }

  # creating logback-additional-appenders.xml
  file { "/home/$codenvy_user/codenvy-data/conf/logback/logback-additional-appenders.xml":
    ensure  => "present",
    content => template("multi_server/api_instance/logback-additional-appenders.xml.erb"),
    owner   => $codenvy_user,
    group   => $codenvy_user,
    mode    => "644",
    require => File[$config_dirs],
    notify  => Class["multi_server::api_instance::service"],
  }

  # creating oauth.properties
  file { "/home/$codenvy_user/codenvy-data/conf/oauth.properties":
    ensure  => "present",
    content => template("multi_server/api_instance/oauth.properties.erb"),
    owner   => $codenvy_user,
    group   => $codenvy_user,
    mode    => "644",
    require => File[$config_dirs],
    notify  => Class["multi_server::api_instance::service"],
  }

  # creating analytics.properties
  file { "/home/$codenvy_user/codenvy-data/conf/analytics.properties":
    ensure  => "present",
    content => template("multi_server/api_instance/analytics.properties.erb"),
    owner   => $codenvy_user,
    group   => $codenvy_user,
    mode    => "644",
    require => File[$config_dirs],
    notify  => Class["multi_server::api_instance::service"],
  }

  # creating billing.properties
  file { "/home/$codenvy_user/codenvy-data/conf/billing.properties":
    ensure  => "present",
    content => template("multi_server/api_instance/billing.properties.erb"),
    owner   => $codenvy_user,
    group   => $codenvy_user,
    mode    => "644",
    require => File[$config_dirs],
    notify  => Class["multi_server::api_instance::service"],
  }

  # creating metrics.properties
  file { "/home/$codenvy_user/codenvy-data/conf/metrics.properties":
    ensure  => "present",
    content => template("multi_server/api_instance/metrics.properties.erb"),
    owner   => $codenvy_user,
    group   => $codenvy_user,
    mode    => "644",
    require => File[$config_dirs],
    notify  => Class["multi_server::api_instance::service"],
  }

  # creating everrest.properties
  file { "/home/$codenvy_user/codenvy-data/conf/everrest.properties":
    ensure  => "present",
    content => template("multi_server/api_instance/everrest.properties.erb"),
    owner   => $codenvy_user,
    group   => $codenvy_user,
    mode    => "644",
    require => File[$config_dirs],
    notify  => Class["multi_server::api_instance::service"],
  }

  # creating machine.properties
  file { "/home/$codenvy_user/codenvy-data/conf/machine.properties":
    ensure  => "present",
    content => template("multi_server/api_instance/machine.properties.erb"),
    owner   => $codenvy_user,
    group   => $codenvy_user,
    mode    => "644",
    require => File[$config_dirs],
    notify  => Class["multi_server::api_instance::service"],
  }

  # creating rsyncbackup.sh
  file { "/usr/local/bin/rsyncbackup.sh":
    ensure  => "present",
    content => template("multi_server/api_instance/rsyncbackup.sh.erb"),
    owner   => root,
    group   => root,
    mode    => "755",
    require => File[$config_dirs],
    notify  => Class["multi_server::api_instance::service"],
  }

  # creating rsyncrestore.sh
  file { "/usr/local/bin/rsyncrestore.sh":
    ensure  => "present",
    content => template("multi_server/api_instance/rsyncrestore.sh.erb"),
    owner   => root,
    group   => root,
    mode    => "755",
    require => File[$config_dirs],
    notify  => Class["multi_server::api_instance::service"],
  }

  # key for rsync
  file { "/home/$codenvy_user/.ssh/key.pem":
    ensure  => "present",
    content => "$private_key",
    mode    => "600",
    owner   => $codenvy_user,
    group   => $codenvy_user,
  }

  # JMX
  file { "/home/$codenvy_user/jmxremote.access":
    ensure  => "present",
    content => "$jmx_username readwrite",
    mode    => "644",
    owner   => $codenvy_user,
    group   => $codenvy_user,
    notify  => Class["multi_server::api_instance::service"],
  }

  file { "/home/$codenvy_user/jmxremote.password":
    ensure  => "present",
    content => "$jmx_username $jmx_password",
    mode    => "644",
    owner   => $codenvy_user,
    group   => $codenvy_user,
    notify  => Class["multi_server::api_instance::service"],
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

  third_party::limits::limits { 'root_nofile':
    ensure     => present,
    user       => "root",
    limit_type => 'nofile',
    hard       => 16384,
    soft       => 16384,
  }
}
