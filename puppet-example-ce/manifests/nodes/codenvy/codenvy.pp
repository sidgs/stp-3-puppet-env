node "codenvy_configs" {
  $host_url = "ec2-52-44-153-60.compute-1.amazonaws.com"
  ###############################
  # swarm nodes management
  #
  $swarm_nodes = "$host_url:2375"
  $codenvy_saas = "false"
  $aio = "true"
  $env = "prod"
  $target_server = "prod"
  $on_prem = "true"
  $version = "4.3.4"
  $private_key = "-----BEGIN RSA PRIVATE KEY-----
MIIEpAIBAAKCAQEArk9w/ZgKEy27a1GCZ6XCqlP8odsrKonhxc3/Grsvu4GLsmaf
gvi6NMWEN6T8PMDXnHRXx1nIlkJP0QTEBhU0h+X2BaVABmFRoVqq9WF94PE59+xt
WrZInhXywAXgSb9SdvsfQH8BugLCI9D+ipE2IPoG/xQIM3ygomcT7r/L8rDjEyru
wZsmeaZ62huOymcpPanV/NJ14tEVbHuEQB0/VzAjSlL+J4QXLVT13O7wSuwt6ZYD
H4vvuDIRtdT511INE+di8Cl8IvexXhIhVXjeirFbZQwouNW71GiHHNcXjjQYCSYf
oFROPr1H9nahmrt+Gf+OvUThVmkfb6Yc4Ji0BwIDAQABAoIBACXXsVwc6fMH9qxx
4bHG1uBLo4kwH8r4bD+ZXUzcXpyCn2V3yiGRBjv2taGu++PkqeqZh4UMBPQ6KUHj
mvsHF4R5dFP9cEzyS9qP6JWlOMLhHAirF4KeGF3Zvf3aSLs6Ahk6o6pI6IMNnkBQ
WzKSHAJExcgS/UTQRb98SWOH2Cszx9euftWGxYb1dQ5b17qSI4Xk/Vt49/MNV3pV
K4K55eIjCyFdlu6qWjgMHt2ofcWttS6UCbAP45zSoJkwKR4uU1xFBWWaL9DRD1hM
2Fv6kVQAxVWX0JVxYOY+WraHIO0ypVBlU5x14Aza+DR9edXu16GcXuyyLFtV0laf
yCxtlkECgYEA5HH91SHMiBTeuUiM+7I5kLHGtvIsJWUlVATR+OITYJSOoLZfV59g
D7dREAJNDe9/7koeLfv+oj/TYkw9zkCOSvxhUcj2dE82sVsm9F5QtZl/QtGLediP
wph2pytVATHK+k1gFfQyCgKWNaVN/slkazgp3W1kb7uRebA9VZf0eF8CgYEAw1Xa
Sdghnjf19gngOU2w1TeZpw7apcagREDuK90vf/liTARJAKJ1e/BAX3Peo0WNl2wP
HD6DO4li+lZcVCNn0uLn/T3zGFOO584ESBVnZhIxR78YpWzeb/4ip1vGnQMsr/7N
hcow3g8wQ8VKD4EUndl8cHJ5lB+pRKavZ0VfBVkCgYEAzQ811rc8LXruYkspolVd
LvEletrvnbGpTD33bP0if7NaRBDwjGrXg8P90+z81eGCaJfHd2eYLnQ0fywI3rc8
AzuA8DUAZW8lnRZBZWGz+Q8MGSKXnIw0n2zUNULETwovNXd3JL3KnQmtZAI6fNay
eTw0+DpVyaYI876rj8WTAOkCgYEAu68wEKfklVt7ry4KDcVCVXwY3NV+7K4Oq8Yf
knHyA+qgsh2j70Ip1C4iDBUPJJ3d0FJ5qk++VGRLf/GewRFL3us6sK7ndsZClyPy
JTi7ou10AFXy3m/ewojSzy91hMPaGjifTR/bGGJLo7Ja2M7T+l9QG9NCUjqhr17h
Rj73b/ECgYBixW3yisKLycF5h5rr/C/3S38sE5p9DyH3QY8tDLz8lCZc23e8qBcG
UcVyJppBgsECJs1xvEnxZOKDE2CHu4TFtKKYn1QvnPvAZWZRXjbgh+BMXMaGbWe1
Chtjmv1ue3jISlK+toJXJvxZJJwknmivLiBylgZO3pNDRLUeXf0qeQ==
-----END RSA PRIVATE KEY-----"
  $public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCuT3D9mAoTLbtrUYJnpcKqU/yh2ysqieHFzf8auy+7gYuyZp+C+Lo0xYQ3pPw8wNecdFfHWciWQk/RBMQGFTSH5fYFpUAGYVGhWqr1YX3g8Tn37G1atkieFfLABeBJv1J2+x9AfwG6AsIj0P6KkTYg+gb/FAgzfKCiZxPuv8vysOMTKu7BmyZ5pnraG47KZyk9qdX80nXi0RVse4RAHT9XMCNKUv4nhBctVPXc7vBK7C3plgMfi++4MhG11PnXUg0T52LwKXwi97FeEiFVeN6KsVtlDCi41bvUaIcc1xeONBgJJh+gVE4+vUf2dqGau34Z/469ROFWaR9vphzgmLQH ec2-user@ip-10-0-0-216.ec2.internal"
  $codenvy_install_type = "single_server"

  ##############################
  # http / https configuration
  #
  $host_protocol = "http"
  # Values below will be used only if $host_protocol = "http" is used
  #
  # Path to ssl cert
  # NOTE: cert should be installed manually
  $path_to_haproxy_ssl_certificate = "/etc/haproxy/cert.pem"
  # haproxy additional ssl config
  $haproxy_https_config = "no-sslv3 no-tls-tickets ciphers ALL:-ADH:+HIGH:+MEDIUM:-LOW:-SSLv2:-EXP:!RC4:!AECDH"
  $path_to_nginx_ssl_certificate = "$path_to_haproxy_ssl_certificate"
  $path_to_nginx_ssl_certificate_key = "$path_to_haproxy_ssl_certificate"

  ################################
  # Mail server configuration
  #
  # Use local mail server postfix to send mails
  # this true by defaul and don't require any additional configuration,
  # please set this to "false" if custom mail server configuration required.
  $use_local_mail_host = "true"
  #
  # Custom mail server configuration
  # properties below will be ignored if $use_local_mail_host is set to "true"
  # In order to configure custom mail server, $use_local_mail_host property must be set to "false"
  #
  $mail_host = "smtp.example.com"
  $mail_host_port = "465"
  $mail_use_ssl = "true"
  $mail_transport_protocol = "smtp"
  $mail_smtp_auth = "true"
  $mail_smtp_socketFactory_class = "javax.net.ssl.SSLSocketFactory"
  $mail_smtp_socketFactory_fallback = "false"
  $mail_smtp_socketFactory_port = "465"
  $mail_smtp_auth_username = "smtp_username"
  $mail_smtp_auth_password = "smtp_password"

  ################################
  # Error reports
  # Logback reports configuration
  #
  # email adress to send report
  $email_to = "ayeluri@liquidhub.com"
  $email_from = "noreply@$host_url"
  $email_subject = "Codenvy $host_url error: %logger{20} - %m"

  ###############################
  # Mongo configurations
  #
  # (Mandatory) replace placeholders with some passwords
  $mongo_admin_pass = "password"
  $mongo_user_pass = "password"
  $mongo_orgservice_user_pwd = "password"
  $mongo_machine_password = "password"
  #
  $mongo_db_path = "/var/lib/mongo"
  $mongo_admin_db_name = "admin"
  $mongo_admin_user_name = "SuperAdmin"
  $mongo_user_name = "FactoryUser"
  $mongo_db_name = "factory"
  $mongo_orgservice_user_name = "CodenvyOrgserviceUser"
  $mongo_orgservice_db_name = "organization"
  $mongo_machine_user_name = "MachinesUser"
  $mongo_machine_db_name = "machines"

  ###############################
  # LDAP configurations
  #
  # LDAP server address
  $ldap_protocol = "ldap"
  $ldap_host = "localhost"
  $ldap_port = "389"
  # (Mandatory) replace placeholder with some password
  # That pass will be used for $java_naming_security_principal for access to LDAP
  $user_ldap_password = "password"
  $java_naming_security_principal = "cn=Admin,dc=codenvy-enterprise,dc=com"
  $java_naming_security_authentication = "simple"
  #
  # connection pool configurations
  $ldap_connect_pool = "true"
  $ldap_connect_pool_initsize = "10"
  $ldap_connect_pool_maxsize = "20"
  $ldap_connect_pool_prefsize = "10"
  $ldap_connect_pool_timeout = "300000"
  #
  # ldap dn configurations
  $user_ldap_dn = "dc=codenvy-enterprise,dc=com"
  $user_ldap_users_ou = "users"
  $user_ldap_user_container_dn = "ou=$user_ldap_users_ou,$user_ldap_dn"
  $user_ldap_user_dn = "uid"
  $user_ldap_old_user_dn = "cn"
  $user_ldap_object_classes = "inetOrgPerson"
  $user_ldap_attr_name = "cn"
  $user_ldap_attr_id = "uid"
  $user_ldap_attr_password = "userPassword"
  $user_ldap_attr_email = "mail"
  $user_ldap_attr_aliases = "initials"
  # each user should have defined $user_ldap_attr_role_name property
  $user_ldap_attr_role_name = "employeeType"
  $user_ldap_allowed_role = "NULL"
  #
  # user profile mappings
  $profile_ldap_profile_container_dn = "ou=$user_ldap_users_ou,$user_ldap_dn"
  $profile_ldap_profile_dn = "uid"
  $profile_ldap_attr_id = "uid"
  $profile_ldap_allowed_attributes = "givenName=firstName,telephoneNumber=phone,mail=email,sn=lastName,o=employer,st=country,title=jobtitle"
  #
  # Pre-installed admin user in default codenvy LDAP
  # (Mandatory) Codenvy admin user name
  $admin_ldap_user_name = "admin"
  # (Mandatory) Codenvy admin mail
  $admin_ldap_mail = "$admin_ldap_user_name@codenvy.onprem"
  # (Mandatory) Codenvy admin password
  $admin_ldap_password = "password"

  ###############################
  # HAPROXY configurations
  #
  # (Mandatory) replace placeholder with some password
  $haproxy_statistic_pass = "password"

  ###############################
  # PGSQL Server, used as back-end for billing
  #
  # (Mandatory) replace placeholder with some password
  $pgsql_pass = "password"
  #
  $pgsql_username = "pgcodenvy"
  $pgsql_database_name = "dbcodenvy"
  $pgsql_listen_addresses = "*"
  $pgsql_port = "5432"
  $pgsql_max_connections = "200"
  $pgsql_shared_buffers = "256MB"
  $pgsql_work_mem = "6553kB"
  $pgsql_maintenance_work_mem = "64MB"
  $pgsql_wal_buffers = "7864kB"
  $pgsql_checkpoint_segments = "32"
  $pgsql_checkpoint_completion_target = "0.9"
  $pgsql_effective_cache_size = "768MB"
  $pgsql_default_statistics_target = "100"
  # MUST BE FALSE ON PROD
  $dbcodenvy_clean_on_startup = "false"

  ###############################
  # JMX credentials
  #
  # (Mandatory) replace placeholders with some username and password
  $jmx_username = "admin"
  $jmx_password = "password"

  ###############################
  # Java XMX config
  #
  # (Optional)  xmx configuration for codenvy servers, if not configured default value 1024 will be used.
  $codenvy_server_xmx = "2048"

  ###############################
  # oAuth configurations
  #
  # (Optional) enter your oAuth client and secrets for integration with google, github, bitbucket and wso2.
  # Please note that oAuth integration is optional, if you don't want to use oAuth leave this as it is.
  # But it will affect on some functionality that depends on oAuth services like github integration.
  #
  # Google. Optional, but it can be used to log in / register an account
  $google_client_id = "NULL"
  $google_secret = "NULL"
  # Github. Optional, but it can be used to log in / register an account
  $github_client_id = "423531cf41d6c13e1b3b"
  $github_secret = "e708bfc28c541a8f25feac4466c93611d9018a3d"
  # BitBucket. Leave is as is, unless you need to use BitBucket oAuth.
  $bitbucket_client_id = "your_bitbucket_client_id"
  $bitbucket_secret = "your_bitbucket_secret"
  # WSO2. Leave is as is, unless you need to use WSO2 oAuth. Visit - https://cloud.wso2.com/
  $wso2_client_id = "your_wso2_client_id"
  $wso2_secret = "your_wso2_secret"
  # ProjectLocker. Leave it as is, unless you need oAuth with ProjectLocker. Visit - http://projectlocker.com/
  $projectlocker_client_id = "your_projectlocker_client_id"
  $projectlocker_secret = "your_projectlocker_secret"
  # Microsoft
  $microsoft_client_id = "NULL"
  $microsoft_secret = "NULL"

  ###############################
  # Codenvy Workspace configurations
  #
  # Allow users self registration, if false only admin will be allowed to create new users.
  $user_self_creation_allowed = "true"
  # Limits
  $limits_user_workspaces_count = "30"
  $limits_user_workspaces_ram = "100gb"
  $limits_workspace_env_ram = "16gb"

  ###############################
  # Codenvy machine configurations
  #
  $machine_extra_hosts = "$host_url:172.17.42.1"
  $machine_ws_agent_inactive_stop_timeout_ms = "28800000"
  $machine_default_mem_size_mb = "1024"
  $machine_ws_agent_max_start_time_ms = "300000"
  $machine_ws_agent_run_command = "sleep 5 && mkdir -p ~/che && rm -rf ~/che/* && unzip -q /mnt/che/ws-agent.zip -d ~/che/ws-agent && ~/che/ws-agent/bin/catalina.sh run"
  # Docker privilege mode, default false
  $machine_docker_privilege_mode = "false"
  # Allows to adjust machine swap memory by multiplication current machnine memory on provided value.
  # default is 0 which means disabled swap, if set multiplier value equal to 0.5 machine swap will be
  # configured with size that equal to half of current machine memory.
  $machine_docker_memory_swap_multiplier = "-1"

  # Docker distribution config
  $docker_distribution_filesystem_root_dir = "/tmp/registry"
  $docker_distribution_http_port = "5000"
  $docker_distribution_http_secret = "your_sercret_here"

  # Docker config
  #
  # additional docker registry example "<DNS>:5000"
  $docker_registry_url = "$host_url:5000"
  #
  # docker registry mirror
  # example "http://<your-docker-mirror-host>:5000"
  # please leave emty if you don't need registry mirror
  $docker_registry_mirror = ""
  #
  # custom registry credentials for docker client
  $docker_registry_auth_url = "http://$docker_registry_url"
  $docker_registry_auth_username = "NULL"
  $docker_registry_auth_password = "NULL"
  #
  #
  # Docker storage backends
  # Supported docker storage backends:
  #    - loopback
  #    - directlvm
  #    - btrfs
  #    - overlayfs
  #
  # IMPORTANT:
  #    - default storage backend is loopback. Not recommended for production use.
  #    - directlvm option require two extra parameters to be passed: $docker_dm_datadev and $docker_dm_metadatadev. Using
  #      LVM, create 2 devices, one large for Docker thinp data, one smaller for thinp metadata and pass it's paths
  #      to $docker_dm_datadev and $docker_dm_metadatadev respectively.
  #    - btrfs option will only configure docker to use btrfs driver. $docker_storage_path must be pointed to some folder
  #      with btrfs filesystem.
  #    - overlayfs is supported only on Centos7.x with custom kernel 4.x
  #    - to avoid conflicts each docker storage backend must have different storage path.
  #
  # EXAMPLES:
  #    loopback
  #        $docker_storage_type = "loopback"
  #        $docker_storage_path = "/var/lib/docker"
  #
  #    directlvm
  #        $docker_storage_type = "loopback"
  #        $docker_storage_path = "/var/lib/docker"
  #        $docker_dm_datadev = ""
  #        $docker_dm_metadatadev = ""
  #
  #    btrfs
  #        $docker_storage_type = "loopback"
  #        $docker_storage_path = "/var/lib/docker"
  #
  #    overlayfs
  #        $docker_storage_type = "loopback"
  #        $docker_storage_path = "/var/lib/docker"

  $docker_storage_type = "loopback"
  $docker_storage_path = "/var/lib/docker"
  $docker_dm_basesize = "10G"
  # for directlvm only
  $docker_dm_datadev = ""
  $docker_dm_metadatadev = ""

  ###############################
  # IM configs
  $saas_api_endpoint = "http://a1.codenvy-dev.com/api"
  $installation_manager_update_server_endpoint = "http://updater-nightly.codenvy-dev.com/update"

  ###############################
  # Monitoring tools
  #
  # If $install_monitoring_tools set to true zabbix and sysdig tools will be installed.
  $install_monitoring_tools = "false"
  #
  # Monitoring tools configurations (will be used only if  $install_monitoring_tools = "false" )
  #
  ###############################
  # ZABBIX
  #
  # (Mandatory) replace placeholder with some password
  $zabbix_db_pass = "password"

  # (Mandatory) zabbix time zone, please select your time zone.
  # possible values can be found here: http://php.net/manual/en/timezones.php
  $zabbix_time_zone = "Europe/Riga"

  # (Mandatory) zabbix admin email, where zabbix will send notifications
  $zabbix_admin_email = "root@localhost"

  # Override default admin password
  # default zabbix admin credentials is:
  # Username: admin
  # Password: zabbix
  $zabbix_admin_password = "zabbix"

  # (Mandatory) zabbix server dns name and entry point, by default those values should be same as codenvy, so please don't
  # change those values.
  $zabbix_server = "$host_url"
  $zabbix_entry_point_url = "$host_url"

  ###############################
  # Http proxy configuration
  # leave those fields empty if no configuration needed
  #
  # http proxy for codenvy
  $http_proxy_for_codenvy = ""
  $https_proxy_for_codenvy = ""
  # provide dns which proxy should not be used for.
  # please leave this empty if you don't need no_proxy configuration
  $no_proxy_for_codenvy = ""
  #
  # http proxy for codenvy workspaces
  $http_proxy_for_codenvy_workspaces = "$http_proxy_for_codenvy"
  $https_proxy_for_codenvy_workspaces = "$https_proxy_for_codenvy"
  # provide dns which proxy should not be used for.
  # please leave this empty if you don't need no_proxy configuration
  $no_proxy_for_codenvy_workspaces = "$no_proxy_for_codenvy"
  #
  # docker proxy config
  # just in case if you need configure separate http_proxy for docker daemon
  # please leave this as is if you don't need separate http_proxy for docker
  $http_proxy_for_docker_daemon = "$http_proxy_for_codenvy"
  $https_proxy_for_docker_daemon = "$https_proxy_for_codenvy"
}

###############################
# DNS names
#
# (Mandatory) set-up dns names of each node of codenvy enterprise.
# Replace example dns names with your actual dns names.
#
# Please note that there is used regular expressions for machine nodes,
# to be able to use same instructions for multiple instances of machine servers.
# Each dns name of machine must be configured like this:
# node1.example.com
# node2.example.com
# node[n].example.com
#
# Additional info: http://docs.puppetlabs.com/puppet/latest/reference/lang_node_definitions.html#regular-expression-names
#
#
# Site instance, please replace "site.example.com" with your actual dns name
node "ec2-52-44-153-60.compute-1.amazonaws.com" inherits "codenvy_configs" {
  include all_in_one
  include codenvy_im
}

# machine instance, please replace /^node\d+\.example\.com$/ with your actual dns name
node /^node\d+\.ec2-52-44-153-60.compute-1.amazonaws.com$/ inherits "codenvy_configs" {
  $machine_target_server = "$env"
  $machine_version = "$version"
  include multi_server::machine_instance::init
}
