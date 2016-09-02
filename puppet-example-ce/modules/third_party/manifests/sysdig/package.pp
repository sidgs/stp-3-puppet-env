class third_party::sysdig::package {
  package { "sysdig":
    ensure  => "installed",
    require => Class["third_party::sysdig::repo"]
  }
}
