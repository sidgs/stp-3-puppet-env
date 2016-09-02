class third_party::pgsql::package {

  $repo = "[pgdg95]
name=PostgreSQL 9.5 \$releasever - \$basearch
baseurl=https://download.postgresql.org/pub/repos/yum/9.5/redhat/rhel-\$releasever-\$basearch
enabled=1
gpgcheck=0

[pgdg95-source]
name=PostgreSQL 9.5 \$releasever - \$basearch - Source
failovermethod=priority
  baseurl=https://download.postgresql.org/pub/repos/yum/srpms/9.5/redhat/rhel-\$releasever-\$basearch
enabled=0
gpgcheck=0
"
  exec { "dump_pg94_if_exist":
    provider => shell,
    command  => "/usr/pgsql-9.4/bin/pg_dumpall > /var/lib/pgsql/dump_9.4.sql",
    user     => postgres,
    onlyif   => "test -d /var/lib/pgsql/9.4/data/base && test -f /usr/pgsql-9.4/bin/pg_dumpall && ! test -f /var/lib/pgsql/dump_9.4.sql",
    timeout  => 600,
  } ->
  package { "postgresql94-server":
    ensure => absent,
  } ->
  package { "postgresql94-contrib":
    ensure => absent,
  } ->
  file { "/etc/yum.repos.d/pgdg-95-centos.repo":
    ensure  => "present",
    content => $repo,
    owner   => root,
    group   => root,
    mode    => "644",
  } ->
  package { "postgresql95-server":
    ensure => installed,
  } ->
  package { "postgresql95-contrib":
    ensure => installed,
  }
}
