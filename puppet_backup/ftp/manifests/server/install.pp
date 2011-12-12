class ftp::server::install{

  include ftp::server::params

  package {$ftp::server::params::pkg_name:
    ensure => installed 
  } 
 
}
