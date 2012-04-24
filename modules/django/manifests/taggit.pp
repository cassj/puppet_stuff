class django::taggit{

  include django::params, python::params

  exec{"$python::params::pip_binary install django-taggit":}

}
