class django::install{

  include django::params

  package{$django::params::pkg_name :
    ensure => present
  }

}
