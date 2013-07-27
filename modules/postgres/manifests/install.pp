class postgres::install{
  
  include postgres::params

  Exec{ path => $postgres::params::path }

  group{$postgres::params::group:
    ensure => present,
  }
  
  user{$postgres::params::user:
    ensure  => present,
    gid     => $postgres::params::group,
    home    => $postgres::params::libdir,
    shell   => '/bin/bash',
    require => Group[$postgres::params::group]
  }

  file{$postgres::params::libdir:
    ensure  => present,
    owner   => $postgres::params::user,
    group   => $postgres::params::group,
    mode    => 700,
    require => User[$postgres::params::user]

  }

  package{$postgres::params::pkg:
    ensure => present
  }

  exec{'postgres-initdb':
    command => "service $postgres::params::service initdb",
    creates => "$postgres::params::datadir/pg_log",
    require => Package[$postgres::params::pkg]
  }

}
