class ftp::client {
  include ftp::client::params
  package {$ftp::client::params::pkgname:
    ensure => installed
  }
}

class ftp::server {
  include ftp::client, ftp::server::params, ftp::server::install, ftp::server::config, ftp::server::service
}

