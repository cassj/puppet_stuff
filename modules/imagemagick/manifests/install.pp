class imagemagick::install{

  include imagemagick::params

  package {$imagemagick::params::pkg:
    ensure => present
  }

}
