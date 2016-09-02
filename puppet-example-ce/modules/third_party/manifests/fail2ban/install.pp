class third_party::fail2ban::install {
  include third_party::fail2ban::package
  include third_party::fail2ban::config
  include third_party::fail2ban::service
}