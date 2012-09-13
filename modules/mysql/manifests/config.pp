class mysql::config($configsource){

  file{$mysql::params::cfg_file:
    ensure  => present,
    source  => $configsource,
    owner   => $mysql::params::user,
    group   => $mysql::params::user,
    require => Class['mysql::install'],
    notify  => Class['mysql::service'],
  }

  file {$mysql::params::var_dir:
    group  => $mysql::params::user,
    owner  => $mysql::params::user,
    recurse => true,
    require => File[$mysql::params::cfg_file]
  }

}
