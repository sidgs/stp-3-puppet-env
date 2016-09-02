class all_in_one::install {
  include all_in_one::configs
  include all_in_one::package
  include all_in_one::service
}