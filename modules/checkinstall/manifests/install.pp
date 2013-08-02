class checkinstall::install {
  package {$checkinstall::params::pkg_name:
    ensure => installed,
  }
}
