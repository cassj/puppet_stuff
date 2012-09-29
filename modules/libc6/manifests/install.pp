class libc6::install {
  package {$libc6::params::pkg_name:
    ensure => installed,
  }
}
