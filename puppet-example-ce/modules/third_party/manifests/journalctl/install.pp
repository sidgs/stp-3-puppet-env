class third_party::journalctl::install {
  file { "/var/log/journal":
    ensure  => "directory",
    owner   => 0,
    force   => true,
    group   => "systemd-journal",
  }
}
