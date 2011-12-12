class ldap::server::install {
  package {$ldap::server::params::pkg_name:
    ensure => installed,
  }
}
