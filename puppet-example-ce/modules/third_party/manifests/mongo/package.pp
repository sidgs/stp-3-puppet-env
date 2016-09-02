class third_party::mongo::package {

  if $operatingsystemrelease =~ /6./ {
    $mongodb_version = "3.0.5-1.el6"
  } elsif $operatingsystemrelease =~ /7./ {
    $mongodb_version = "3.2.1-1.el7"
  }

  package { "mongodb-org":
    ensure  => $mongodb_version,
    require => [Class["third_party::codenvy_repo::install"], Class["third_party::mongo::repo"]],
  }
}
