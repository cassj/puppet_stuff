class libicu::install {
  package {$libicu::params::pkg_name:
    ensure => installed,
  }
}
