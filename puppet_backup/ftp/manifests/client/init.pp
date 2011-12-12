class ftp::client {
  include ftp::client::params
  package {$ftp::client::params::pkgname:
    ensure => installed
  }
}
