class git::gitweb::install {
  package {$git::gitweb::params::pkg_name:
    ensure => installed,
  }
}
