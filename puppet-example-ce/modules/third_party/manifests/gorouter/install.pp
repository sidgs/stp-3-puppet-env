class third_party::gorouter::install {
  #Gntasd is a dependency for gorouter
  include third_party::gnatsd::install

  include third_party::gorouter::package
  include third_party::gorouter::config
  include third_party::gorouter::service
}
