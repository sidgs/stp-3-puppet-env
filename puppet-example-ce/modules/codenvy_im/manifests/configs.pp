class codenvy_im::configs {
  $config_dirs = [
    "/home/codenvy-im/archives",
    "/home/codenvy-im/codenvy-im-data/",
    "/home/codenvy-im/codenvy-im-data/conf",
    "/home/codenvy-im/codenvy-im-tomcat"]

# creating folders
  file { $config_dirs:
    ensure  => "directory",
    owner   => "codenvy-im",
    group   => "codenvy-im",
    mode    => 755,
    require => Class["codenvy_im::user"]
  }

  # creating folder for im data
  file { "/usr/local/codenvy":
    ensure  => "directory",
    owner   => "codenvy-im",
    group   => "codenvy-im",
    mode    => 755,
    require => Class["codenvy_im::user"]
  }

# creating .bashrc
  file { "/home/codenvy-im/.bashrc":
    ensure  => "present",
    content => template("codenvy_im/bashrc.erb"),
    owner   => "codenvy-im",
    group   => "codenvy-im",
    mode    => 644,
    require => Class["codenvy_im::user"],
    notify  => Class["codenvy_im::service"]
  }

# prepare codenvy im tomcat service
  file { "/usr/lib/systemd/codenvy-im":
    ensure  => "present",
    content => template("codenvy_im/codenvy-im.el7.erb"),
    mode    => 755,
    owner   => "root",
    group   => "root",
    notify  => Class["codenvy_im::service"],
  } ->
  file { "/usr/lib/systemd/system/codenvy-im.service":
    ensure  => "present",
    content => template("codenvy_im/codenvy-im.service.erb"),
    mode    => 644,
    owner   => "root",
    group   => "root",
    notify  => Class["codenvy_im::service"],
  } ->
  file { "/etc/systemd/system/multi-user.target.wants/codenvy-im.service":
    ensure => link,
    target => "/usr/lib/systemd/system/codenvy-im.service",
  }

# creating installation-manager.properties
  file { "/home/codenvy-im/codenvy-im-data/conf/installation-manager.properties":
    ensure  => "present",
    content => template("codenvy_im/installation-manager.properties.erb"),
    owner   => "codenvy-im",
    group   => "codenvy-im",
    mode    => 644,
    require => File[$config_dirs],
    notify  => Class["codenvy_im::service"]
  }

# creating logback-smtp-appender.xml
  file { "/home/codenvy-im/codenvy-im-data/conf/logback-smtp-appender.xml":
    ensure  => "present",
    content => template("codenvy_im/logback-smtp-appender.xml.erb"),
    owner   => "codenvy-im",
    group   => "codenvy-im",
    mode    => 644,
    require => File[$config_dirs],
    notify  => Class["codenvy_im::service"]
  }

  third_party::limits::limits { 'codenvy-im_nofile':
    ensure     => present,
    user       => "codenvy-im",
    limit_type => 'nofile',
    hard       => 16384,
    soft       => 16384,
  }

  third_party::limits::limits { 'codenvy-im_nproc':
    ensure     => present,
    user       => "codenvy-im",
    limit_type => 'nproc',
    hard       => 16384,
    soft       => 16384,
  }
}
