class vsftpd::install {
  package {$vsftpd::params::pkg_name:
    ensure => installed,
  }
}
