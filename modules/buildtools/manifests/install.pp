class buildtools::install {
  package {$buildtools::params::pkg_name:
    ensure => installed,
  }
}
