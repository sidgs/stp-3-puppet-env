class third_party::redis::install {
  include third_party::redis::package
  include third_party::redis::config
  include third_party::redis::service
}
