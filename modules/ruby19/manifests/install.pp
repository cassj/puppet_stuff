class ruby19::install {
  package {$ruby19::params::pkg_name:
    ensure => installed,
  }
}
