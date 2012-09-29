class libmysqlplusplus::install {
  package {$libmysqlplusplus::params::pkg_name:
    ensure => installed,
  }
}
