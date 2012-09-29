class python::dev{

  include python::params

  package{$python::params::dev_pkg_name :
    ensure => present
  }

}
