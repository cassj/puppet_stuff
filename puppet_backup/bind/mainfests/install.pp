class bind::install{
  Package { $bind::params::pkg_name:
    ensure => present,
  }
}

