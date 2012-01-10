class ant::install{

  include ant::params

  package{$ant::params::pkg_name:
    ensure => present
  }

}
