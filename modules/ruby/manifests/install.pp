class ruby::install {
  package {$ruby::params::pkg_name:
    ensure => installed,
  }
}
