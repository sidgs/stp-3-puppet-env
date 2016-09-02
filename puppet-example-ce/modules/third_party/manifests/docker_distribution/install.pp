class third_party::docker_distribution::install {
  include third_party::redis::install

  include third_party::docker_distribution::package
  include third_party::docker_distribution::config
  include third_party::docker_distribution::service
}
