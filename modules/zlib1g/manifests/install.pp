class zlib1g::install {
  package {$zlib1g::params::pkg_name:
    ensure => installed,
  }
}
