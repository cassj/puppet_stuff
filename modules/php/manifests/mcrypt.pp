class php::mcrypt{
 
  include php::params

  package{ $php::params::mcrypt_pkg_name:
    ensure => installed 
  }

}
