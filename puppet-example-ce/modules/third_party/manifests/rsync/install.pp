class third_party::rsync::install {
  package { "rsync":
    ensure  => "3.1.1-1.el7.rfx",
    require => Class["third_party::epel::install"]
  }
}
