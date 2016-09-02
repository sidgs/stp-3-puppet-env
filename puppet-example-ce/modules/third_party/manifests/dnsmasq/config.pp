class third_party::dnsmasq::config {

  file { "/etc/dnsmasq.conf":
    ensure  => "present",
    content => template("third_party/dnsmasq/dnsmasq.conf.erb"),
    owner   => root,
    group   => root,
    mode    => 644,
    require => Class["third_party::dnsmasq::package"],
    notify  => Class["third_party::dnsmasq::service"]
  }
}
