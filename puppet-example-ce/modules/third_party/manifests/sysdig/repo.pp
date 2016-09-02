class third_party::sysdig::repo {
  $repo = "[draios]
name=Draios
baseurl=http://download.draios.com/stable/rpm/\$basearch
enabled=1
gpgcheck=0
"

  file { "/etc/yum.repos.d/draios.repo":
    ensure  => "present",
    content => $repo,
    owner   => root,
    group   => root,
    mode    => "644",
  }
}

