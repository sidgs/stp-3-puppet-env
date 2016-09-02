class third_party::zabbix::repo {
  $repo = "[zabbix]
name=Zabbix Official Repository - \$basearch
baseurl=http://repo.zabbix.com/zabbix/3.0/rhel/7/\$basearch/
enabled=1
gpgcheck=0

[zabbix-non-supported]
name=Zabbix Official Repository non-supported - \$basearch.
baseurl=http://repo.zabbix.com/non-supported/rhel/7/\$basearch/
enabled=1
gpgcheck=0
"

  file { "/etc/yum.repos.d/zabbix.repo":
    ensure  => "present",
    content => $repo,
    owner   => root,
    group   => root,
    mode    => "644",
  }
}
