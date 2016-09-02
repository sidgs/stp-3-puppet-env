class third_party::limits ($purge_limits_d_dir = true) inherits third_party::limits::params {
  file { $third_party::limits::params::limits_dir:
    ensure  => directory,
    owner   => 'root',
    group   => 'root',
    force   => true,
    purge   => $purge_limits_d_dir,
    recurse => true,
  }
}
