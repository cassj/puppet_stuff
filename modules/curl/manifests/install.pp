class curl::install {
  package {$curl::params::pkg_name:
    ensure => installed,
  }
}
