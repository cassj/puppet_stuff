class php::mysql{
 
  include php::params

  package{ $php::params::mysql_pkg_name:
    ensure => installed 
  }

}
