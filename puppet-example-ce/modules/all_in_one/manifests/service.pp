class all_in_one::service {
  $require_arr = [
    Class["third_party::jdk::install"],
    Class["third_party::postfix::install"],
    Class["third_party::openldap_servers::service"],
    Class["third_party::mongo::service"],
    Class["third_party::haproxy::service"],
    Class["third_party::docker::service"],
    Class["all_in_one::package"],
    Class["third_party::pgsql::service"]]

  service { "codenvy":
    ensure     => running,
    enable     => true,
    hasstatus  => true,
    hasrestart => true,
    require    => $require_arr,
    subscribe  => [Class["third_party::mongo::service"], Class["third_party::jdk::install"]]
  }
}
