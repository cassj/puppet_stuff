class rsync::install {
  package {$rsync::params::pkg_name:
    ensure => installed,
  }
}
