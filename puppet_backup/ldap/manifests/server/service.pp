class ldap::server::service {

  include $ldap::server::params

  service{ $ldap::server::params::service:
    ensure     => running,
    hasstatus  => true,
    hasrestart => true,
    enable     => true,
    require    => Class['ldap::server::config'],
  }
}
