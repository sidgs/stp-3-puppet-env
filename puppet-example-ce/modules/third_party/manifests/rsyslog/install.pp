class third_party::rsyslog::install ($is_analytics = "false") {
  include third_party::rsyslog::package

  class { "third_party::rsyslog::config": analytics_fix => $is_analytics }
  include third_party::rsyslog::service
}