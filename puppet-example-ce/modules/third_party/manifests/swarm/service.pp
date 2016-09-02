class third_party::swarm::service {
  file { "/usr/local/swarm/node_list":
    ensure  => "present",
    content => template("third_party/swarm/node_list.erb"),
    mode    => "644",
    owner   => root,
    group   => root,
    require => Class["third_party::swarm::config"],
  } ->
  service { "swarm":
    ensure     => running,
    enable     => true,
    hasrestart => true,
    hasstatus  => true,
    subscribe  => File["/usr/local/swarm/node_list"]
  }
}
