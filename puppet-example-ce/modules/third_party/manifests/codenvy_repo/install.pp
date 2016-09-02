class third_party::codenvy_repo::install {
  file { "/etc/yum.repos.d/Codenvy.repo":
    ensure  => "present",
    content => template("third_party/codenvy_repo/Codenvy.repo.erb"),
    owner   => root,
    group   => root,
    mode    => "644",
  }
}
