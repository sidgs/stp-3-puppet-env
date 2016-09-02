class codenvy_user {
  group { $codenvy_groups:
    ensure => "present",
    gid    => "5001",
  }

  user { $codenvy_user:
    ensure     => "present",
    home       => "/home/$codenvy_user",
    shell      => "/bin/bash",
    managehome => true,
    groups     => $codenvy_groups,
    uid        => "5001",
    gid        => "5001",
    require    => Group["$codenvy_groups"]
  }

  file { "/home/$codenvy_user/.ssh":
    ensure  => directory,
    mode    => "700",
    owner   => $codenvy_user,
    group   => $codenvy_groups,
    require => User["$codenvy_user"]
  }

  file { "/home/$codenvy_user/.ssh/authorized_keys":
    ensure  => "present",
    mode    => "600",
    content => $public_key,
    owner   => $codenvy_user,
    group   => $codenvy_groups,
    require => File["/home/$codenvy_user/.ssh"]
  } ->
  # creating /etc/sudoers.d/codenvy
  file { "/etc/sudoers.d/codenvy":
    ensure  => "present",
    content => "codenvy ALL=(ALL) NOPASSWD:ALL
Defaults:codenvy        !requiretty
",
    owner   => root,
    group   => root,
    mode    => "644",
  }
}
