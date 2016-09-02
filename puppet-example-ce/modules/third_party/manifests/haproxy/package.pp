class third_party::haproxy::package {
# install haproxy version depends on os version.
  if $operatingsystemrelease =~ /6./ {
    $haproxy_version = "1.5.2-2.el6"
  } elsif $operatingsystemrelease =~ /7./ {
    $haproxy_version = "1.5.2-3.el7_0"
  }

  package { "haproxy":
    ensure  => $haproxy_version,
    require => Class["third_party::codenvy_repo::install"]
  }
}