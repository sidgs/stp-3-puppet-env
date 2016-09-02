class third_party::nginx::repo {
  $repo = "[nginx]
name=nginx repo
baseurl=http://nginx.org/packages/centos/7/\$basearch/
gpgcheck=0
enabled=1
"
  file { "/etc/yum.repos.d/nginx.repo":
    ensure  => "present",
    content => $repo,
    owner   => root,
    group   => root,
    mode    => "644",
  }
}
