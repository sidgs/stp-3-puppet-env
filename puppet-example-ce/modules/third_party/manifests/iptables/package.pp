class third_party::iptables::package {
# install iptables depends on os version.
  if $operatingsystemrelease =~ /6./ {
    package { "iptables": ensure => installed }
  } elsif $operatingsystemrelease =~ /7./ {
    package { "firewalld": ensure => installed, } ->
    # TODO use ensure => masked once such functionality will be available.
    service { "firewalld":
      ensure => stopped,
      enable => false,
    } ->
    package { "iptables-services": ensure => installed }
  }
}