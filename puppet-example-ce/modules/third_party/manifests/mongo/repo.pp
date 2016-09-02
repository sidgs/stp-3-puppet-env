class third_party::mongo::repo {
  $repo = "[mongodb-org-3.2]
name=MongoDB Repository
baseurl=https://repo.mongodb.org/yum/redhat/\$releasever/mongodb-org/3.2/x86_64/
gpgcheck=0
enabled=1
"

  file { "/etc/yum.repos.d/mongo-org-3.2.repo":
    ensure  => "present",
    content => $repo,
    owner   => root,
    group   => root,
    mode    => "644",
  }
}
