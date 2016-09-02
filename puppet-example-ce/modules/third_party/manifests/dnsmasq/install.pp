class third_party::dnsmasq::install {
  include third_party::dnsmasq::package
  include third_party::dnsmasq::config
  include third_party::dnsmasq::service
}
