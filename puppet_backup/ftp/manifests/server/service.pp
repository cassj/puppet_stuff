class ftp::server::service {
  
  include ftp::server::params

  service {$ftp::server::params::service:
    ensure => running,
    hasstatus  => true,
    hasrestart => true,
    enable     => true,
    require    => Class['ftp::server::install']
  }

}
