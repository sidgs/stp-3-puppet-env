define third_party::limits::limits ($user, $limit_type, $ensure = present, $hard = undef, $soft = undef, $both = undef) {
  include third_party::limits::params
  include third_party::limits::kernel_semaphores

  if $name =~ /\.conf$/ {
    $target_file = "${third_party::limits::params::limits_dir}${name}"
  } else {
    $target_file = "${third_party::limits::params::limits_dir}${name}.conf"
  }

  file { $target_file:
    ensure  => $ensure,
    owner   => 'root',
    group   => 'root',
    content => template('third_party/limits/limits.erb'),
  }
}
