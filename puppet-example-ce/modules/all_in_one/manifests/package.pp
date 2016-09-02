class all_in_one::package {

  if $codenvy_saas == "false" or $codenvy_saas == undef {
    $classifier = "onpremises"
  } else {
    $classifier = "saas"
  }

  if $env == "dev.box" {
    $tomcat_source = "puppet:///modules/all_in_one/$classifier-ide-packaging-tomcat-codenvy-allinone.zip"
    $ext_server_tomcat_source = "puppet:///modules/all_in_one/$classifier-ide-packaging-tomcat-ext-server.zip"
    $websocket_terminal_source = "puppet:///modules/all_in_one/$classifier-ide-packaging-zip-terminal.zip"
  } elsif $env == "dev" {
    $tomcat_source = "puppet:///file/servers/$target_server/aio/$classifier-ide-packaging-tomcat-codenvy-allinone.zip"
    $ext_server_tomcat_source = "puppet:///file/servers/$target_server/aio/$classifier-ide-packaging-tomcat-ext-server.zip"
    $websocket_terminal_source = "puppet:///file/servers/$target_server/aio/$classifier-ide-packaging-zip-terminal.zip"
  } elsif $env == "prod" {
    $tomcat_source = "puppet:///file/servers/$target_server/aio/$classifier-ide-packaging-tomcat-codenvy-allinone-$version.zip"
    $ext_server_tomcat_source = "puppet:///file/servers/$target_server/aio/$classifier-ide-packaging-tomcat-ext-server-$version.zip"
    $websocket_terminal_source = "puppet:///file/servers/$target_server/aio/$classifier-ide-packaging-zip-terminal-$version.zip"
  }

  # download ext server zip
  file { "/home/$codenvy_user/archives/ext-server.zip":
    ensure  => file,
    owner   => $codenvy_user,
    group   => $codenvy_groups,
    mode    => "0755",
    source  => $ext_server_tomcat_source,
    # this is for avoid filling up of /var/lib/puppet/clientbucket with backups of large files.
    backup  => false,
    require => [Class["codenvy_user"], Class["all_in_one::configs"]],
  } ->
    # download aio zip
  file { "/home/$codenvy_user/archives/aio-tomcat.zip":
    ensure  => file,
    owner   => $codenvy_user,
    group   => $codenvy_groups,
    mode    => "0755",
    source  => $tomcat_source,
    # this is for avoid filling up of /var/lib/puppet/clientbucket with backups of large files.
    backup  => false,
    require => [Class["codenvy_user"], Class["all_in_one::configs"]],
    notify  => Exec['/etc/update_codenvy_tomcat.sh'],
  }

  # /etc/update_codenvy_tomcat.sh
  file { "/etc/update_codenvy_tomcat.sh":
    ensure  => "present",
    content => template("all_in_one/update_codenvy_tomcat.sh.erb"),
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
    notify      => Class["all_in_one::service"],
    require     => [
      Class["codenvy_user"],
      Class["all_in_one::configs"],
      File["/home/$codenvy_user/archives/aio-tomcat.zip"],
      File["/etc/update_codenvy_tomcat.sh"]]
  }

  exec { "check_is_tomcat_unpacked_successfully":
    logoutput => true,
    command   => "echo recovering tomcat",
    user      => root,
    unless    => "test -d bin && test -d webapps",
    cwd       => "/home/$codenvy_user/codenvy-tomcat/",
    notify    => Exec["/etc/update_codenvy_tomcat.sh"],
    require   => File["/home/$codenvy_user/archives/aio-tomcat.zip"]
  }

  # server.xml
  file { "/home/$codenvy_user/codenvy-tomcat/conf/server.xml":
    ensure  => "present",
    content => template("all_in_one/server.xml.erb"),
    owner   => $codenvy_user,
    group   => $codenvy_user,
    mode    => "664",
    require => Exec["/etc/update_codenvy_tomcat.sh"],
    notify  => Class["all_in_one::service"],
  }

  # download websocket terminal zip
  file { "/home/$codenvy_user/archives/terminal.zip":
    ensure  => file,
    owner   => $codenvy_user,
    group   => $codenvy_groups,
    mode    => "0755",
    source  => $websocket_terminal_source,
    # this is for avoid filling up of /var/lib/puppet/clientbucket with backups of large files.
    backup  => false,
    require => [Class["codenvy_user"], Class["all_in_one::configs"]],
    notify  => Exec["unpack_websocket_terminal"]
  }

  exec { "unpack_websocket_terminal":
    logoutput   => true,
    command     => "rm -rf terminal; unzip archives/terminal.zip",
    user        => $codenvy_user,
    cwd         => "/home/$codenvy_user/",
    refreshonly => true,
    require     => File["/home/$codenvy_user/archives/terminal.zip"]
  }
}
