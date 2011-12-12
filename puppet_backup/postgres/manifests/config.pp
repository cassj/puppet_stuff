class postgres::config{
 
  include postgres::params

  file {$postgres::params::config_file:
    ensure => present,
    source => 'puppet:///modules/postgres/pg_hba.conf',
    owner  => $postgres::params::user,
    group  => $postgres::params::group,
    mode   => 600,
    notify => Service[$postgres::params::service]
  }
}
