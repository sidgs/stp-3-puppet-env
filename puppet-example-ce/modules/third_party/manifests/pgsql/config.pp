class third_party::pgsql::config {
  # using different init commands depends on os version.
  if $operatingsystemrelease =~ /7./ {
    $init_command = "/usr/pgsql-9.5/bin/postgresql95-setup initdb"
  } else {
    $init_command = "service postgresql-9.5 initdb"
  }
  exec { 'exec-pgsql-initdb':
    command  => "$init_command",
    timeout  => 600,
    creates  => '/var/lib/pgsql/9.5/data/base',
    require  => Class["third_party::pgsql::package"],
  } ->
  file { 'pg_hba.conf':
    content                 => template('third_party/pgsql/pg_hba.conf.erb'),
    ensure                  => file,
    path                    => '/var/lib/pgsql/9.5/data/pg_hba.conf',
    mode                    => "0600",
    owner                   => 'postgres',
    group                   => 'postgres',
    require                 => Class["third_party::pgsql::package"],
    notify                  => Class["third_party::pgsql::service"],
    selinux_ignore_defaults => true,
  } ->
  file { 'postgresql.conf':
    content                 => template('third_party/pgsql/postgresql.conf.erb'),
    ensure                  => file,
    path                    => '/var/lib/pgsql/9.5/data/postgresql.conf',
    mode                    => "0600",
    owner                   => 'postgres',
    group                   => 'postgres',
    require                 => Class["third_party::pgsql::package"],
    notify                  => Class["third_party::pgsql::service"],
    selinux_ignore_defaults => true,
  }
}
