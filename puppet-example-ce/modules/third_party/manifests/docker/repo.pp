class third_party::docker::repo {
  $repo = "[dockerrepo]
name=Docker Repository
baseurl=https://yum.dockerproject.org/repo/main/centos/7
enabled=1
gpgcheck=1
gpgkey=https://yum.dockerproject.org/gpg
"
  file { "/etc/yum.repos.d/docker.repo":
    ensure  => "present",
    content => $repo,
    owner   => root,
    group   => root,
    mode    => "644",
  }
}
