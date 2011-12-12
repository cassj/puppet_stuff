class mysql::install {

  user {$mysql::params::user:
    ensure  => present,
    comment => 'MySQL user',
    gid     => $mysql::params::user,
    shell   => $mysql::params::shell,
    require => Group[$mysql::params::user]
  }

  group{$mysql::params::user:
    ensure  => present
  }

  package {$mysql::params::pkg_name:
    ensure  => present,
    require => User[$mysql::params::user]
  }

  
}
