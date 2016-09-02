class third_party::mongo::config ($mongo_db_path) {
  file { "/etc/init.d/mongod":
    ensure  => "present",
    content => template("third_party/mongo/mongod.erb"),
    owner   => root,
    group   => root,
    mode    => "755",
    selinux_ignore_defaults => true,
    require => Class["third_party::mongo::package"],
    notify  => Class["third_party::mongo::service"]
  } ->
  file { "/etc/mongod.conf":
    ensure  => "present",
    content => template("third_party/mongo/mongod.conf.erb"),
    owner   => root,
    group   => root,
    mode    => "644",
    require => Class["third_party::mongo::package"],
    notify  => Class["third_party::mongo::service"]
  }

  if $operatingsystemrelease =~ /7./ {
    exec { "systemctl_daemon_reload":
      command     => "systemctl daemon-reload",
      logoutput   => true,
      refreshonly => true,
      subscribe   => File["/etc/init.d/mongod"]
    }
  }
}
