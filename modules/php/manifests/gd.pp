class php::gd{
 
  include php::params

  package{ $php::params::gd_pkg_name:
    ensure => installed 
  }

}
