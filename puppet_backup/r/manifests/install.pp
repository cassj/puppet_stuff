class r::install{
 
  include r::params

  package{$r::params::pkg:
    ensure => installed
  }

}
