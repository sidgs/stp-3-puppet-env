class third_party::nginx::install {
  include third_party::nginx::repo
  include third_party::nginx::package
  include third_party::nginx::config
  include third_party::nginx::service
}
