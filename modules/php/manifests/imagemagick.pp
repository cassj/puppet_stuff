class php::imagemagick{
  
  include php::params, imagemagick

  package{$php::params::imagemagick_pkg_name:
    ensure => present
  }
}
