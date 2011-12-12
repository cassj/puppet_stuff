class mysql::service {

  service{ $mysql::params::service:
    ensure     => running,
    hasstatus  => true,
    hasrestart => true,
    enable     => true,
    require    => Class['mysql::config'],
  }

  
}
