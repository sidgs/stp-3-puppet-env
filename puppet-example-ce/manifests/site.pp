import "*/*/*.pp"

# PLEASE NOTE! IF YOU WANT TO ADD NEW HOST IN NODES FOLDER SITE.PP MUST BE MODIFIED SOMEHOW TO INVOKE REPARSE IT BY PUPPET MASTER.
# detail: http://serverfault.com/questions/510485/puppetcould-not-find-default-node-or-by-name-with-node-test2
# directive import loads nodes only once.

# GLOBAL INCLUDES
include third_party::epel::install
include third_party::wget::install
include third_party::unzip::install
include third_party::tar::install
include third_party::puppet::install
include third_party::mc::install
include third_party::fail2ban::install
include third_party::logwatch::install
include third_party::cron::install
include third_party::ntp::install
include third_party::logrotate::install
include third_party::postfix::install
include third_party::jq::install
include third_party::openssh::install
include third_party::nmap::install
include third_party::curl::install
include third_party::codenvy_repo::install
include third_party::yum_cron::install
include third_party::iptables::install
include third_party::journalctl::install

# GLOBAL DEFINITIONS
Exec {
  path => ["/bin/", "/sbin/", "/usr/bin/", "/usr/sbin/"] }

# CODENVY_USER
$codenvy_user = "codenvy"
$codenvy_groups = ["codenvy"]

# clean up
package { "mysql-server":
  ensure  => absent,
}
package { "mysql":
  ensure  => absent,
}