class vim::install {
  package {$vim::params::pkg_name:
    ensure => installed,
  }
}
