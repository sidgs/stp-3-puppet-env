class third_party::puppet::install {
  include third_party::puppet::package
  include third_party::puppet::config
  include third_party::puppet::service
}
