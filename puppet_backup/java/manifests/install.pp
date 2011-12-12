class java::install {

  include java::params

  package {$java::params::pkgname:
    ensure => present
  }
}
