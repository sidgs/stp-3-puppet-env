class all_in_one::configs {
  if $codenvy_server_xmx == undef {
    $xmx = "1024"
  } else {
    $xmx = $codenvy_server_xmx
  }

  $config_dirs = [
    "/home/$codenvy_user/codenvy-tomcat/",
    "/home/$codenvy_user/archives",
    "/home/$codenvy_user/codenvy-data/",
    "/home/$codenvy_user/codenvy-data/logs",
    "/home/$codenvy_user/codenvy-data/fs",
    "/home/$codenvy_user/codenvy-data/che-machines",
    "/home/$codenvy_user/codenvy-data/che-machines-logs",
    "/home/$codenvy_user/codenvy-data/conf",
    "/home/$codenvy_user/codenvy-data/conf/logback"]

  # adding codenvy user in postgres db
  third_party::pgsql::pgutils::create_user { "$pgsql_username":
    password  => "$pgsql_pass",
    #superuser => true
  } -> # adding codenvy database in postgres db
  third_party::pgsql::pgutils::create_database { "$pgsql_database_name":
    dbowner => "$pgsql_username"
  } ->
    # changing iptables
  file { "/etc/sysconfig/iptables":
    ensure  => "present",
    content => template("all_in_one/iptables.erb"),
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
    content => template("all_in_one/bashrc.erb"),
    owner   => $codenvy_user,
    group   => $codenvy_user,
    mode    => "644",
    require => Class["codenvy_user"],
    notify  => Class["all_in_one::service"],
  }

  # creating oauth.properties
  file { "/home/$codenvy_user/codenvy-data/conf/oauth.properties":
    ensure  => "present",
    content => template("all_in_one/oauth.properties.erb"),
    owner   => $codenvy_user,
    group   => $codenvy_user,
    mode    => "644",
    require => File[$config_dirs],
    notify  => Class["all_in_one::service"],
  }

  # creating factory.properties
  file { "/home/$codenvy_user/codenvy-data/conf/factory.properties":
    ensure  => "present",
    content => template("all_in_one/factory.properties.erb"),
    owner   => $codenvy_user,
    group   => $codenvy_user,
    mode    => "644",
    require => File[$config_dirs],
    notify  => Class["all_in_one::service"],
  }

  # creating email-connection.properties
  file { "/home/$codenvy_user/codenvy-data/conf/email-connection.properties":
    ensure  => "present",
    content => template("all_in_one/email-connection.properties.erb"),
    owner   => $codenvy_user,
    group   => $codenvy_user,
    mode    => "644",
    require => File[$config_dirs],
    notify  => Class["all_in_one::service"],
  }

  # creating email.properties
  file { "/home/$codenvy_user/codenvy-data/conf/email.properties":
    ensure  => "present",
    content => template("all_in_one/email.properties.erb"),
    owner   => $codenvy_user,
    group   => $codenvy_user,
    mode    => "644",
    require => File[$config_dirs],
    notify  => Class["all_in_one::service"],
  }

  # creating logback-additional-appenders.xml
  file { "/home/$codenvy_user/codenvy-data/conf/logback/logback-additional-appenders.xml":
    ensure  => "present",
    content => template("all_in_one/logback-additional-appenders.xml.erb"),
    owner   => $codenvy_user,
    group   => $codenvy_user,
    mode    => "644",
    require => File[$config_dirs],
    notify  => Class["all_in_one::service"],
  }

  # prepare aio tomcat service
  file { "/usr/lib/systemd/codenvy":
    ensure  => "present",
    content => template("all_in_one/codenvy.el7.erb"),
    mode    => "755",
    owner   => "root",
    group   => "root",
    notify  => Class["all_in_one::service"],
  } ->
  file { "/usr/lib/systemd/system/codenvy.service":
    ensure  => "present",
    content => template("all_in_one/codenvy.service.erb"),
    mode    => "644",
    owner   => "root",
    group   => "root",
    notify  => Class["all_in_one::service"],
  } ->
  file { "/etc/systemd/system/multi-user.target.wants/codenvy.service":
    ensure => link,
    target => "/usr/lib/systemd/system/codenvy.service",
  }

  # creating general.properties
  file { "/home/$codenvy_user/codenvy-data/conf/general.properties":
    ensure  => "present",
    content => template("all_in_one/general.properties.erb"),
    owner   => $codenvy_user,
    group   => $codenvy_user,
    mode    => "644",
    require => File[$config_dirs],
    notify  => Class["all_in_one::service"],
  }

  # creating mongo.properties
  file { "/home/$codenvy_user/codenvy-data/conf/mongo.properties":
    ensure  => "present",
    content => template("all_in_one/mongo.properties.erb"),
    owner   => $codenvy_user,
    group   => $codenvy_user,
    mode    => "644",
    require => File[$config_dirs],
    notify  => Class["all_in_one::service"],
  }

  # creating ldap.properties
  file { "/home/$codenvy_user/codenvy-data/conf/ldap.properties":
    ensure  => "present",
    content => template("all_in_one/ldap.properties.erb"),
    owner   => $codenvy_user,
    group   => $codenvy_user,
    mode    => "644",
    require => File[$config_dirs],
    notify  => Class["all_in_one::service"],
  }

  # creating billing.properties
  file { "/home/$codenvy_user/codenvy-data/conf/billing.properties":
    ensure  => "present",
    content => template("all_in_one/billing.properties.erb"),
    owner   => $codenvy_user,
    group   => $codenvy_user,
    mode    => "644",
    require => File[$config_dirs],
    notify  => Class["all_in_one::service"],
  }

  # creating metrics.properties
  file { "/home/$codenvy_user/codenvy-data/conf/metrics.properties":
    ensure  => "present",
    content => template("all_in_one/metrics.properties.erb"),
    owner   => $codenvy_user,
    group   => $codenvy_user,
    mode    => "644",
    require => File[$config_dirs],
    notify  => Class["all_in_one::service"],
  }

  # creating everrest.properties
  file { "/home/$codenvy_user/codenvy-data/conf/everrest.properties":
    ensure  => "present",
    content => template("all_in_one/everrest.properties.erb"),
    owner   => $codenvy_user,
    group   => $codenvy_user,
    mode    => "644",
    require => File[$config_dirs],
    notify  => Class["all_in_one::service"],
  }

  # creating machine.properties
  file { "/home/$codenvy_user/codenvy-data/conf/machine.properties":
    ensure  => "present",
    content => template("all_in_one/machine.properties.erb"),
    owner   => $codenvy_user,
    group   => $codenvy_user,
    mode    => "644",
    require => File[$config_dirs],
    notify  => Class["all_in_one::service"],
  }

  # creating rsyncbackup.sh
  file { "/usr/local/bin/rsyncbackup.sh":
    ensure  => "present",
    content => template("all_in_one/rsyncbackup.sh.erb"),
    owner   => root,
    group   => root,
    mode    => "755",
    require => File[$config_dirs],
    notify  => Class["all_in_one::service"],
  }

  # creating rsyncrestore.sh
  file { "/usr/local/bin/rsyncrestore.sh":
    ensure  => "present",
    content => template("all_in_one/rsyncrestore.sh.erb"),
    owner   => root,
    group   => root,
    mode    => "755",
    require => File[$config_dirs],
    notify  => Class["all_in_one::service"],
  }

  # JMX
  file { "/home/$codenvy_user/jmxremote.access":
    ensure  => "present",
    content => "$jmx_username readwrite",
    mode    => "644",
    owner   => $codenvy_user,
    group   => $codenvy_user,
  }

  file { "/home/$codenvy_user/jmxremote.password":
    ensure  => "present",
    content => "$jmx_username $jmx_password",
    mode    => "644",
    owner   => $codenvy_user,
    group   => $codenvy_user,
  }

  # key for rsync
  file { "/home/$codenvy_user/.ssh/key.pem":
    ensure  => "present",
    content => "$private_key",
    mode    => "600",
    owner   => $codenvy_user,
    group   => $codenvy_user,
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
    hard       => 163840,
    soft       => 163840,
  }

  #TODO This is clean up, should be removed after few next major versions
  #remove obsolete folders
  file { "/home/$codenvy_user/codenvy-data/cloud-ide-local-configuration":
    ensure => "absent",
    force  => true
  }
  file { "/home/$codenvy_user/codenvy-data/docker":
    ensure  => "absent",
    force   => true,
  }

  # TODO workaround for puppet bug with mem leaks when serve large files
  if $on_prem == "true" {
    cron { "restart_puppetmaster_to_avoid_memleaks":
      command => "/bin/systemctl restart  puppetmaster.service",
      minute  => "3",
      hour    => "2",
      user    => root,
    }
  }
}
