class codenvy_im {

# required props
#  $codenvy_saas_host_url = "https://codenvy-stg.com"
#  $node_ssh_user_private_key = ""
#  $node_ssh_user_name = ""
#  $puppet_master_host_name = "localhost"

  include codenvy_im::user
  include third_party::jdk::install
  include codenvy_im::configs
  include codenvy_im::package
  include codenvy_im::service
}
