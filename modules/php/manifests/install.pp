class php::install{
 
  include php::params

  package{ $php::params::pkg_name:
    ensure => installed 
  }

}
