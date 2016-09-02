class multi_server::machine_instance::package {

  if $codenvy_saas == "false" or $codenvy_saas == undef {
    $classifier = "onpremises"
  } else {
    $classifier = "saas"
  }

  if $env == "local" {
    $ext_server_tomcat_source = "puppet:///modules/multi_server/$classifier-ide-packaging-tomcat-ext-server.zip"
    $websocket_terminal_source = "puppet:///modules/multi_server/$classifier-ide-packaging-zip-terminal.zip"
  } elsif $env == "dev.box" {
    $ext_server_tomcat_source = "puppet:///modules/multi_server/$classifier-ide-packaging-tomcat-ext-server.zip"
    $websocket_terminal_source = "puppet:///modules/multi_server/$classifier-ide-packaging-zip-terminal.zip"
  } elsif $env == "dev" {
    $ext_server_tomcat_source = "puppet:///file/servers/$machine_target_server/machine/$classifier-ide-packaging-tomcat-ext-server.zip"
    $websocket_terminal_source = "puppet:///file/servers/$machine_target_server/machine/$classifier-ide-packaging-zip-terminal.zip"
  } elsif $env == "prod" {
    $ext_server_tomcat_source = "puppet:///file/servers/$machine_target_server/machine/$classifier-ide-packaging-tomcat-ext-server-$machine_version.zip"
    $websocket_terminal_source = "puppet:///file/servers/$machine_target_server/machine/$classifier-ide-packaging-zip-terminal-$machine_version.zip"
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
    require => [Class["codenvy_user"], Class["multi_server::machine_instance::configs"]],
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
    require => [Class["codenvy_user"], Class["multi_server::machine_instance::configs"]],
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
