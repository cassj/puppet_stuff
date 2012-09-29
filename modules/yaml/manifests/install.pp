class yaml::install {
  package {$yaml::params::pkg_name:
    ensure => installed,
  }
}
