class git::install {
  package {$git::params::pkg_name:
    ensure => installed,
  }
}
