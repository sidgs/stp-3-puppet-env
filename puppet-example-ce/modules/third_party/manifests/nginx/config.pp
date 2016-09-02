class third_party::nginx::config {
  if $host_protocol == "https" {
    $nginx_config_file = "third_party/nginx/https_nginx.conf.erb"
  } else {
    $nginx_config_file = "third_party/nginx/http_nginx.conf.erb"
  }

  file { "/etc/nginx/nginx.conf":
    ensure  => "present",
    content => template($nginx_config_file),
    owner   => root,
    group   => root,
    mode    => 644,
    require => Class["third_party::nginx::package"],
    notify  => Class["third_party::nginx::service"]
  }
}
