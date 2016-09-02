class third_party::openldap_servers::service {
  service { "slapd":
    ensure     => running,
    enable     => true,
    hasrestart => true,
    hasstatus  => true,
    require    => Class["third_party::openldap_servers::config"],
  }
}