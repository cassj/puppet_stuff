class postfix::install {
  package { $postfix::params::pkg_name:
    ensure => present,
  }
  file{$postfix::params::dir:
   ensure => directory,
   owner  => $postfix::params::user,
   group  => $postfix::params::user,
   require => Package[$postfix::params::pkg_name]
  }
}
