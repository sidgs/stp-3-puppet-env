class multi_server::analytics_instance::install {
  include multi_server::analytics_instance::configs
  include multi_server::analytics_instance::package
  include multi_server::analytics_instance::service
}