class sqldeveloper::install {
  package {$sqldeveloper::params::pkg_name:
    ensure => installed,
  }
}
