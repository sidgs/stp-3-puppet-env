class codenvy_im::service {
  $require_arr = [Class["third_party::jdk::install"], Class["codenvy_im::package"]]

  service { "codenvy-im":
    ensure     => running,
    enable     => true,
    hasstatus  => true,
    hasrestart => true,
    require    => $require_arr,
    subscribe  => Class["third_party::jdk::install"]
  }
}
