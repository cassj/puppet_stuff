class php::config($configfile){
  include php::params

  file{"$php::params::configfile":
    ensure => present,
    owner  => 'root',
    group  => 'root',
    mode   => 644,
    source => $configfile
  }

}
