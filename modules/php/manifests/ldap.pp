class php::ldap{
 
  include php::params

  package{ $php::params::ldap_pkg_name:
    ensure => installed 
  }

}
