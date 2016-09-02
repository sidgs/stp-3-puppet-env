class multi_server::site_instance::install {
  include multi_server::site_instance::configs
  include multi_server::site_instance::package
  include multi_server::site_instance::service
}