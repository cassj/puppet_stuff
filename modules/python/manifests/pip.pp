class python::pip{

  include python::params

  package{$python::params::pip_pkg_name :
    ensure => present
  }

}
