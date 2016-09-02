class third_party::redis::config {
  file { "/etc/redis.conf":
    ensure  => "present",
    content => template("third_party/redis/redis.conf.erb"),
    owner   => redis,
    group   => root,
    mode    => 644,
    require => Class["third_party::redis::package"],
    notify  => Class["third_party::redis::service"]
  } ->
  file { "/etc/redis-sentinel.conf":
    ensure  => "present",
    content => template("third_party/redis/redis-sentinel.conf.erb"),
    owner   => redis,
    group   => root,
    mode    => 644,
    require => Class["third_party::redis::package"],
    notify  => Class["third_party::redis::service"]
  }
}
