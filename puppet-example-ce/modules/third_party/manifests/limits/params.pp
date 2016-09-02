class third_party::limits::params {
  case $::osfamily {
    'Debian', 'RedHat' : { $limits_dir = '/etc/security/limits.d/' }
    default            : { fail("Unsupported platform: ${::osfamily}/${::operatingsystem}") }
  }
}
