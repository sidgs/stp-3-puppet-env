class third_party::fail2ban::config {
# Create custom fail2ban config only for CentOS7
  if $operatingsystemrelease =~ /7./ {
    file { "/etc/fail2ban/jail.d/sshd.local":
      ensure  => "present",
      content => template("third_party/fail2ban/sshd.local.erb"),
      owner   => "root",
      group   => "root",
      mode    => "644",
      require => Class["third_party::fail2ban::package"],
      notify  => Class["third_party::fail2ban::service"]
    }
  }
}