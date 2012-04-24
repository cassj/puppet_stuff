class django::install{

  include django::params, python::params

  exec{"$python::params::pip_binary install $django::params::pkg_name":}

}
