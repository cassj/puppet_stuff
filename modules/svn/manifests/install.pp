class svn::install {
  package {$svn::params::pkg_name:
    ensure => installed,
  }
}
