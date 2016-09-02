class codenvy_im::user {
  $codenvy_im_groups = ["codenvy-im"]
  $codenvy_im_user = "codenvy-im"

  group { $codenvy_im_groups:
    ensure => "present",
    gid    => "6001",
  }

  user { $codenvy_im_user:
    ensure     => "present",
    home       => "/home/$codenvy_im_user",
    shell      => "/bin/bash",
    managehome => true,
    groups     => $codenvy_im_groups,
    uid        => "6001",
    gid        => "6001",
    require    => Group["$codenvy_im_groups"]
  }

  file { "/home/$codenvy_im_user/.ssh":
    ensure  => directory,
    mode    => 700,
    owner   => $codenvy_im_user,
    group   => $codenvy_im_groups,
    require => User["$codenvy_im_user"]
  }

  file { "/home/$codenvy_im_user/.ssh/id_rsa":
    ensure  => "present",
    mode    => 600,
    content => "$node_ssh_user_private_key",
    owner   => $codenvy_im_user,
    group   => $codenvy_im_groups,
    require => File["/home/$codenvy_im_user/.ssh"]
  }

# creating /etc/sudoers.d/codenvy-im
  file { "/etc/sudoers.d/codenvy-im":
    ensure  => "present",
    content => "$codenvy_im_user ALL=(ALL) NOPASSWD:ALL
Defaults:$codenvy_im_user !requiretty
",
    owner   => root,
    group   => root,
    mode    => 644,
    require => User["$codenvy_im_user"]
  }
}
