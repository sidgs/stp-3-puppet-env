class third_party::pgsql::pgutils {
# Define: third_party::pgsql::database
#
# This definition creates PostgreSQL database
#
# Parameters:
#   [*dbname*]     - Database name. Default [$name]
#   [*dbencoding*] - Database encoding. Default: UTF8
#   [*dbowner*]    - Database owner. Default: postgres
  define create_database ($dbname = $name, $dbencoding = UTF8, $dbowner = postgres) {
    Exec {
      path => '/bin:/sbin:/usr/bin:/usr/sbin',
      user => postgres
    }

    exec { "postgresql-create-database-${dbname}":
      command => "createdb --template=template0 -E ${dbencoding} -O ${dbowner} ${dbname}",
      timeout  => 600,
      unless  => "psql -aA -l | grep '^${dbname}|'",
      require => Class["third_party::pgsql::service"]
    }
  }

# Define: third_party::pgsql::user
#
# This definition creates a PostgreSQL database user
#
# Parameters:
#   [*username*]         - Username of the new user. Default: [$name]
#   [*password*]         - User password
#   [*createdb*]         - User is allowed to create databases. Default: false
#   [*createrole*]       - User is allowed to create roles. Default: false
#   [*superuser*]        - User is a super user. Default: false
#   [*connection_limit*] - Connection limit. Default: -1
  define create_user (
    $username         = $name,
    $password         = undef,
    $createdb         = false,
    $createrole       = false,
    $superuser        = false,
    $connection_limit = -1) {
    Exec {
      path => '/bin:/sbin:/usr/bin:/usr/sbin',
      user => postgres
    }

    if ($password == undef) {
      fail('You must specify a password')
    }

    $createrole_sql = $createrole ? {
      true    => 'CREATEROLE',
      default => 'NOCREATEROLE'
    }
    $createdb_sql = $createdb ? {
      true    => 'CREATEDB',
      default => 'NOCREATEDB'
    }
    $superuser_sql = $superuser ? {
      true    => 'SUPERUSER',
      default => 'NOSUPERUSER'
    }

    exec { "postgresql-create-user-${username}":
      command => "psql -At --command=\"CREATE ROLE \"${username}\" ENCRYPTED PASSWORD '${password}' LOGIN ${createrole_sql} ${createdb_sql} ${superuser_sql} CONNECTION LIMIT ${connection_limit}\"",
      timeout  => 600,
      unless  => "psql -At --command=\"SELECT rolname FROM pg_roles WHERE rolname='${username}'\" | grep ${username}",
      require => Class["third_party::pgsql::service"]
    }
  }
}
