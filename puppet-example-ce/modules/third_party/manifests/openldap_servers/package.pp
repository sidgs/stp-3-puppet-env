class third_party::openldap_servers::package {
  package { "openldap":
    ensure  => installed,
    require => Class["third_party::epel::install"]
  } ->
  package { "openldap-servers": ensure => installed }
}
