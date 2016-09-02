class third_party::postfix::install {
  package { "postfix": ensure => "installed", }

  service { "postfix":
    ensure     => running,
    enable     => true,
    hasrestart => true,
    hasstatus  => true,
    require    => [Package["postfix"]]
  }
}