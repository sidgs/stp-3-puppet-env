class third_party::pgsql::install {
  include third_party::pgsql::package
  include third_party::pgsql::config
  include third_party::pgsql::service
}
