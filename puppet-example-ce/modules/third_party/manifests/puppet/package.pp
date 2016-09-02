class third_party::puppet::package {
# Different puppet versions depends on OS version.
  if $operatingsystemrelease =~ /6./ {
    package { "puppet": ensure => "3.4.3-1.el6" }
  } elsif $operatingsystemrelease =~ /7./ {
    package { "puppetlabs-release":
      ensure   => installed,
      provider => "yum",
      source   => "http://yum.puppetlabs.com/puppetlabs-release-el-7.noarch.rpm",
    } ->
    package { "puppet": ensure => "3.8.6-1.el7" }
  }
}