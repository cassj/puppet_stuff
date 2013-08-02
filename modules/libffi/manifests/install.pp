class libffi::install {
  package {$libffi::params::pkg_name:
    ensure => installed,
  }
}
