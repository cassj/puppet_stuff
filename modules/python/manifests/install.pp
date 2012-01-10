class python::install{

  include python::params

  package{$python::params::pkg_name :
    ensure => present
  }

}
