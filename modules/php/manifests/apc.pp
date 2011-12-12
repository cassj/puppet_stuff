class php::apc{
 
  include php::params

  package{ $php::params::apc_pkg_name:
    ensure => installed 
  }

}
