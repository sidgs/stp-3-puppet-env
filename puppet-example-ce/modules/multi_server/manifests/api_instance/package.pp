class multi_server::api_instance::package {

  if $codenvy_saas == "false" or $codenvy_saas == undef {
    $classifier = "onpremises"
  } else {
    $classifier = "saas"
  }

  if $env == "local" {
    $tomcat_source = "puppet:///modules/multi_server/$classifier-ide-packaging-tomcat-api.zip"
  } elsif $env == "dev" {
    $tomcat_source = "puppet:///file/servers/$api_target_server/api/$classifier-ide-packaging-tomcat-api.zip"
  } elsif $env == "prod" {
    $tomcat_source = "puppet:///file/servers/$api_target_server/api/$classifier-ide-packaging-tomcat-api-$api_version.zip"
  }

  # download api zip
  file { "/home/$codenvy_user/archives/api-tomcat.zip":
    ensure  => file,
    owner   => $codenvy_user,
    group   => $codenvy_groups,
    mode    => "0755",
    source  => $tomcat_source,
    # this is for avoid filling up of /var/lib/puppet/clientbucket with backups of large files.
    backup  => false,
    require => [Class["codenvy_user"], Class["multi_server::api_instance::configs"]],
    notify  => Exec['/etc/update_codenvy_tomcat.sh'],
  }

  # /etc/update_codenvy_tomcat.sh
  file { "/etc/update_codenvy_tomcat.sh":
    ensure  => "present",
    content => template("multi_server/api_instance/update_codenvy_tomcat.sh.erb"),
    owner   => root,
    group   => root,
    mode    => "755",
  }

  exec { "/etc/update_codenvy_tomcat.sh":
    provider    => shell,
    refreshonly => true,
    user        => root,
    timeout     => 600,
    cwd         => "/home/$codenvy_user/",
    require     => [
      Class["codenvy_user"],
      Class["multi_server::api_instance::configs"],
      File["/home/$codenvy_user/archives/api-tomcat.zip"],
      File["/etc/update_codenvy_tomcat.sh"],
    ]
  }

  exec { "check_is_tomcat_unpacked_successfully":
    logoutput => true,
    command   => "echo recovering tomcat",
    user      => root,
    unless    => "test -d bin && test -d webapps",
    cwd       => "/home/$codenvy_user/codenvy-tomcat/",
    notify    => Exec["/etc/update_codenvy_tomcat.sh"],
    require   => File["/home/$codenvy_user/archives/api-tomcat.zip"]
  }

  # server.xml
  file { "/home/$codenvy_user/codenvy-tomcat/conf/server.xml":
    ensure  => "present",
    content => template("multi_server/api_instance/api_server.xml.erb"),
    owner   => $codenvy_user,
    group   => $codenvy_user,
    mode    => "664",
    require => Exec["/etc/update_codenvy_tomcat.sh"],
    notify  => Class["multi_server::api_instance::service"],
  }
}
