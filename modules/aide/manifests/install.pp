class aide::install {
  package {$aide::params::pkg_name:
    ensure => installed,
  }
}
