class ssh::install {
  package {$ssh::params::pkg_name:
    ensure => installed,
  }
}
