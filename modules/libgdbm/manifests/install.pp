class libgdbm::install {
  package {$libgdbm::params::pkg_name:
    ensure => installed,
  }
}
