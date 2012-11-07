class opal::config ($config, $auth_config){
  file{'/etc/opal/opal-config.properties':
    ensure => file,
    owner  => 'opal',
    group  => 'adm',
    source => $config,
    mode   => 750
  }
  file{'/etc/opal/shiro.ini':
    ensure => file,
    owner  => 'opal',
    group  => 'adm',
    source => $auth_config,
    mode   => 750
  }
}
