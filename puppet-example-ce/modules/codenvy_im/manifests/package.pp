class codenvy_im::package {

  if $codenvy_saas == "false" or $codenvy_saas == undef {
    $classifier = "onpremises"
  } else {
    $classifier = "saas"
  }

  if $env == "dev.box"  {
    $tomcat_source = "puppet:///modules/codenvy_im/$classifier-ide-packaging-tomcat-im.zip"
  } elsif $env == "local" {
    $tomcat_source = "puppet:///modules/codenvy_im/$classifier-ide-packaging-tomcat-im.zip"
  } elsif $env == "onprem" {
    $tomcat_source = "puppet:///file/servers/$target_server/im/$classifier-ide-packaging-tomcat-im.zip"
  } elsif $env == "prod" {
    $tomcat_source = "puppet:///file/servers/prod/im/$classifier-ide-packaging-tomcat-im-$version.zip"
  }

# download codenvy im zip
  file { "/home/codenvy-im/archives/tomcat-im.zip":
    ensure  => file,
    owner   => "codenvy-im",
    group   => "codenvy-im",
    mode    => "0755",
    source  => $tomcat_source,
  # this is for avoid filling up of /var/lib/puppet/clientbucket with backups of large files.
    backup  => false,
    require => [Class["codenvy_im::user"], Class["codenvy_im::configs"]],
    notify  => Exec['/etc/update_codenvy_im_tomcat.sh'],
  }

# /etc/update_codenvy_im_tomcat.sh
  file { "/etc/update_codenvy_im_tomcat.sh":
    ensure  => "present",
    content => template("codenvy_im/update_codenvy_im_tomcat.sh.erb"),
    owner   => root,
    group   => root,
    mode    => 755,
  }

  exec { "/etc/update_codenvy_im_tomcat.sh":
    provider    => shell,
    refreshonly => true,
    user        => root,
    timeout     => 600,
    cwd         => "/home/codenvy-im/",
    notify      => Class["codenvy_im::service"],
    require     => [
      Class["codenvy_im::user"],
      Class["codenvy_im::configs"],
      File["/home/codenvy-im/archives/tomcat-im.zip"],
      File["/etc/update_codenvy_im_tomcat.sh"]]
  }

  exec { "check_is_codenvy_im_tomcat_unpacked_successfully":
    logoutput => true,
    command   => "echo recovering tomcat",
    user      => root,
    unless    => "test -d bin && test -d webapps",
    cwd       => "/home/codenvy-im/codenvy-im-tomcat/",
    notify    => Exec["/etc/update_codenvy_im_tomcat.sh"],
    require   => File["/home/codenvy-im/archives/tomcat-im.zip"]
  }
}
