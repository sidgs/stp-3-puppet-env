class third_party::epel::install {
  package { "epel-release":
    ensure   => installed,
    require  => [Class["third_party::codenvy_repo::install"], Class["third_party::yum_cron::install"]]
  }
}
