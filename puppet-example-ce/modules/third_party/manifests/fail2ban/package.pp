class third_party::fail2ban::package {
  package { "fail2ban":
    ensure  => "installed",
    require => Class["third_party::epel::install"]
  }
}