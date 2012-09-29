class nginx::install {
  package {$nginx::params::pkg_name:
    ensure => installed,
  }
}
