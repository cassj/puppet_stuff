define ldap::server::database ($domain=$name, $cfg_file='puppet:///modules/ldap/server/DB_CONFIG') {
  
  include ldap::server::params

  #create a directory under your ldapdir for this domain
  file {"$ldap::server::params::ldap_dir/$domain":
    ensure  => directory,
    owner   => $ldap::server::params::user,
    group   => $ldap::server::params::group,
    require => Class['ldap::server::install']
  }

  # and create the config file for it
  file {"$ldap::server::params::ldap_dir/$domain/DB_CONFIG":
    ensure  => present,
    owner   => $ldap::server::params::user,
    group   => $ldap::server::params::group,
    source  => $cfg_file,
    require => File["$ldap::server::params::ldap_dir/$domain"]  
  }

}
