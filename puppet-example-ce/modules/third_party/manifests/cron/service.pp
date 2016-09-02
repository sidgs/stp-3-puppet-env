class third_party::cron::service {
  service { "crond":
    ensure     => running,
    enable     => true,
    hasrestart => true,
    hasstatus  => true,
    require    => Class["third_party::cron::package"]
  }
}