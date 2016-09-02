class third_party::mongo::install ($is_analytics = "false") {
  include third_party::mongo::repo
  include third_party::mongo::package

  class { "third_party::mongo::config": mongo_db_path => $mongo_db_path }

  class { "third_party::mongo::service": is_analytics => $is_analytics }
}