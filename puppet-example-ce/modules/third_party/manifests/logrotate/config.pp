class third_party::logrotate::config {
  if $on_prem == "true" {
    if $aio == "true" {
      $rotate_puppet_logs = "/var/log/puppet/*log {
        missingok
        notifempty
        create 0644 puppet puppet
        sharedscripts
        postrotate
            /bin/systemctl restart puppet.service
            /bin/systemctl restart puppetmaster.service
        endscript
      }
      "
    } else {
      $rotate_puppet_logs = "/var/log/puppet/*log {
        missingok
        notifempty
        create 0644 puppet puppet
        sharedscripts
        postrotate
            /bin/systemctl restart puppet.service
        endscript
      }
      "
    }
  } else {
    $rotate_puppet_logs = "/var/log/puppet/*log {
      missingok
      notifempty
      create 0644 puppet puppet
      sharedscripts
      postrotate
          /bin/systemctl restart puppet.service
      endscript
    }
    "
  }
  file { "/etc/logrotate.d/puppet":
    ensure  => "present",
    content => $rotate_puppet_logs,
    owner   => root,
    group   => root,
    mode    => "644",
    require => Class["third_party::logrotate::package"],
  }
}