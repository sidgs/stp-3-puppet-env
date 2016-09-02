class third_party::puppet::service {
  case $operatingsystem {
    centos, redhat  : { $agent_service = "puppet" }
    fedora  : { $agent_service = "puppetagent" }
    default : { fail("Unrecognized operating system") }
  }

  service { $agent_service:
    ensure     => running,
    enable     => true,
    hasrestart => true,
    hasstatus  => true,
    require    => Class["third_party::puppet::config"]
  }
}