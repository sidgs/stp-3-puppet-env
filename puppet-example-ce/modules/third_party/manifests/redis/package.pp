class third_party::redis::package {
  package { "redis":
    ensure  => "2.8.19-2.el7",
    require => Class["third_party::epel::install"]
  }
}
