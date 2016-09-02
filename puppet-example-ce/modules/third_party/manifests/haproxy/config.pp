class third_party::haproxy::config (
  $api_host_name,
  $analytics_host_name,
  $host_url,
  $haproxy_statistic_pass) {
  if $aio == "true" {
    $haproxy_config_source = "third_party/haproxy/haproxy.cfg.erb"
  } else {
    $haproxy_config_source = "third_party/haproxy/haproxy_multi_server.cfg.erb"
  }

  file { "/etc/haproxy/haproxy.cfg":
    ensure  => "present",
    content => template($haproxy_config_source),
    owner   => root,
    group   => root,
    mode    => "644",
    require => Class["third_party::haproxy::package"],
    notify  => Class["third_party::haproxy::service"]
  }
}