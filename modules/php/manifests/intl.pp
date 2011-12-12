class php::intl{
 
  include php::params

  package{ $php::params::intl_pkg_name:
    ensure => installed 
  }

}
