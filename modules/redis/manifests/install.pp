class redis::install {
  package {$redis::params::pkg_name:
    ensure => installed,
  }
}
