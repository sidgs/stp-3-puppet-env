class third_party::pgsql::service {
  service { "postgresql-9.5":
    ensure     => running,
    enable     => true,
    hasrestart => true,
    hasstatus  => true,
    require    => Class["third_party::pgsql::config"]
  } ~>
  exec { "restore_pg_data_if_exist":
    command     => "/usr/pgsql-9.5/bin/psql < /var/lib/pgsql/dump_9.4.sql",
    user        => postgres,
    onlyif      => "test -f /var/lib/pgsql/dump_9.4.sql",
    refreshonly => true,
    timeout     => 600
  }
}
