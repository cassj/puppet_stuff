class sqlite::install {
  package {$sqlite::params::pkg_name:
    ensure => installed,
  }
}
