class third_party::openldap_servers::config (
  $admin_ldap_dn,
  $admin_ldap_user_name,
  $admin_ldap_mail,
  $admin_ldap_password,
  $user_ldap_dn,
  $user_ldap_password) {
  File {
    require => Class["third_party::openldap_servers::package"],
    notify  => Class["third_party::openldap_servers::service"],
    ensure  => "present",
    owner   => root,
    group   => root,
    mode    => "644",
  }

  Exec {
    notify => Class["third_party::openldap_servers::service"], }

  file {
    "/etc/openldap/slapd.conf":
      content => template("third_party/openldap_servers/slapd.conf.erb");

    "/etc/openldap/initial.ldif":
      content => template("third_party/openldap_servers/initial.ldif.erb");
  } ->
  exec { "rename_folder":
    cwd     => "/etc",
    command => "mv -f /etc/openldap/slapd.d /etc/openldap/slapd.d-",
    creates => "/etc/openldap/slapd.d-",
    notify  => Exec["ldap_init"]
  }

  exec { "ldap_init":
    command     => "slapadd < /etc/openldap/initial.ldif",
    refreshonly => true,
    notify      => Exec["chmod_ldap_dir"],
  }

  exec { "chmod_ldap_dir":
    command     => "chown -R ldap:ldap /var/lib/ldap",
    refreshonly => true,
  }
}