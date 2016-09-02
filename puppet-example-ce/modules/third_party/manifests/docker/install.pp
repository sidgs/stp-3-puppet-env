class third_party::docker::install {
  include third_party::docker::repo
  include third_party::docker::package
  include third_party::docker::config
  include third_party::docker::service
}
