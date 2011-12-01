class apache::install {
  package{ $apache::params::pkg_name:
    ensure => present 
  }
}
