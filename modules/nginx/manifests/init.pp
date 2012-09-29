class nginx{
  include nginx::params, nginx::install, nginx::config, nginx::service
}
