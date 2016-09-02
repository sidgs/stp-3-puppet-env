class third_party::mongo::service ($is_analytics) {
  service { "mongod":
    ensure     => running,
    enable     => true,
    hasstatus  => true,
    hasrestart => true,
    require    => Class["third_party::mongo::config"]
  } ->
  exec { "create_admin_user":
    command   => "sleep 30;mongo --eval \"db = db.getSiblingDB('$mongo_admin_db_name'); db.createUser({ user: '$mongo_admin_user_name', pwd: '$mongo_admin_pass', roles: ['userAdminAnyDatabase', 'clusterAdmin', 'readWriteAnyDatabase']});\"",
    unless    => "test `mongo --quiet -u $mongo_admin_user_name -p $mongo_admin_pass --eval \"db.system.users.find({user:'$mongo_admin_user_name'}).count()\" $mongo_admin_db_name` -eq 1",
    logoutput => true,
    timeout   => 600,
  }

  if $is_analytics == "false" {
    exec { "create_factory_user":
      command   => "mongo -u $mongo_admin_user_name -p $mongo_admin_pass --eval \"db = db.getSiblingDB('$mongo_db_name'); db.createUser({ user: '$mongo_user_name', pwd: '$mongo_user_pass', roles: ['readWrite']});\" $mongo_admin_db_name",
      unless    => "test `mongo --quiet -u $mongo_admin_user_name -p $mongo_admin_pass --eval \"db.system.users.find({user:'$mongo_user_name'}).count()\" $mongo_admin_db_name` -eq 1",
      logoutput => true,
      timeout   => 600,
      require   => Exec["create_admin_user"]
    }

    exec { "create_orgservice_user":
      command   => "mongo -u $mongo_admin_user_name -p $mongo_admin_pass --eval \"db = db.getSiblingDB('$mongo_orgservice_db_name'); db.createUser({ user: '$mongo_orgservice_user_name', pwd: '$mongo_orgservice_user_pwd', roles: ['readWrite']});\" $mongo_admin_db_name",
      unless    => "test `mongo --quiet -u $mongo_admin_user_name -p $mongo_admin_pass --eval \"db.system.users.find({user:'$mongo_orgservice_user_name'}).count()\" $mongo_admin_db_name` -eq 1",
      logoutput => true,
      timeout   => 600,
      require   => Exec["create_admin_user"]
    }

    exec { "create_machine_user":
      command   => "mongo -u $mongo_admin_user_name -p $mongo_admin_pass --eval \"db = db.getSiblingDB('$mongo_machine_db_name'); db.createUser({ user: '$mongo_machine_user_name', pwd: '$mongo_machine_password', roles: ['readWrite']});\" $mongo_admin_db_name",
      unless    => "test `mongo --quiet -u $mongo_admin_user_name -p $mongo_admin_pass --eval \"db.system.users.find({user:'$mongo_machine_user_name'}).count()\" $mongo_admin_db_name` -eq 1",
      logoutput => true,
      timeout   => 600,
      require   => Exec["create_admin_user"]
    }

    # add permissions for admin user
    $admin_permissions = "var createAdminsPermissions = function(admins){
  var organizationDb = db.getSiblingDB(\"$mongo_orgservice_db_name\");
  var permissionsCollection = organizationDb.getCollection(\"permissions\");

  var systemDomain = \"system\";
  var instance = null; // system domain support only nullable instance
  var adminsActions = [\"setPermissions\", \"manageUsers\", \"manageCodenvy\"];
  var count = 0;
  print(\"Starting adding system permissions for admins.\");
  print(\"System permissions: [\" + adminsActions + \"].\");
  admins.forEach(function(admin) {
    try {
      permissionsCollection.update({\"user\": admin,
      \"domain\": systemDomain,
      \"instance\": instance},
      {\"user\": admin,
      \"domain\": systemDomain,
      \"instance\": instance,
      \"actions\":adminsActions},
      {\"upsert\":true});
      count++;
      print(\"Added system permissions for admin with id \" + admin + \". \");
    }
    catch(err) {
      print(\"Can't add system permissions for admin with id \" + admin + \". \" + err.message);
    }
  });
  print(\"System permissions for \" + count + \" admins successfully created.\")
}

createAdminsPermissions([\"$admin_ldap_mail\"]);
"

    file { "/var/lib/mongo/admin_permissions.js":
      ensure  => "present",
      content => $admin_permissions,
      owner   => mongod,
      group   => mongod,
      mode    => "600",
      require => Exec["create_orgservice_user"],
      notify  => Exec["add_admin_permissions"]
    } ->
    exec { "add_admin_permissions":
      command     => "mongo -u $mongo_orgservice_user_name -p $mongo_orgservice_user_pwd $mongo_orgservice_db_name /var/lib/mongo/admin_permissions.js",
      logoutput   => true,
      timeout     => 600,
      refreshonly => true,
    }
  } else {
    exec { "create_logreader_user":
      command   => "mongo -u $mongo_admin_user_name -p $mongo_admin_pass --eval \"db = db.getSiblingDB('$mongo_analytics_db_name'); db.createUser({ user: '$mongo_analytics_user_name', pwd: '$mongo_analytics_user_pass', roles: ['readWrite']});\" $mongo_admin_db_name",
      unless    => "test `mongo --quiet -u $mongo_admin_user_name -p $mongo_admin_pass --eval \"db.system.users.find({user:'$mongo_analytics_user_name'}).count()\" $mongo_admin_db_name` -eq 1",
      logoutput => true,
      timeout   => 600,
      require   => Exec["create_admin_user"]
    }
  }
}
