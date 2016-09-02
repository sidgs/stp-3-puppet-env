class third_party::mc::install {
  package { "mc":
    ensure  => "installed",
    require => Class["third_party::epel::install"]
  }
}