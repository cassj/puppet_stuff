class libxml2::install {
  package {$libxml2::params::pkg_name:
    ensure => installed,
  }
}
