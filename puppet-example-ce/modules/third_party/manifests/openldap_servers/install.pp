class third_party::openldap_servers::install {
  include third_party::openldap_servers::package

  class { "third_party::openldap_servers::config":
    admin_ldap_dn        => $admin_ldap_dn,
    admin_ldap_user_name => $admin_ldap_user_name,
    admin_ldap_mail      => $admin_ldap_mail,
    admin_ldap_password  => $admin_ldap_password,
    user_ldap_dn         => $user_ldap_dn,
    user_ldap_password   => $user_ldap_password
  }
  include third_party::openldap_servers::service
}