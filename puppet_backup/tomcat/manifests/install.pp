class tomcat::install{

  include tomcat::params
  include ant 

  #this is already present in sunjava.
#  package {$tomcat::params::ant_pkgname:
#    ensure => present
#  }
#
#  include sunjava

  package {$tomcat::params::pkgname:
    ensure => present
  }

}
