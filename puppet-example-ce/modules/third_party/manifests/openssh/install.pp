class third_party::openssh::install {
  package { "openssh-server": ensure => "installed", }

  package { "openssh-clients":
    ensure  => "installed",
    require => Package["openssh-server"]
  }
}