class postfix::install {
  package { $postfix::params::pkg_name:
    ensure => present,
  }
}
