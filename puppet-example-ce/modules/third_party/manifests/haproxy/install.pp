class third_party::haproxy::install {
  include third_party::haproxy::package

  class { "third_party::haproxy::config":
    api_host_name          => $api_host_name,
    analytics_host_name    => $analytics_host_name,
    host_url               => $host_url,
    haproxy_statistic_pass => $haproxy_statistic_pass
  }
  include third_party::haproxy::service
}