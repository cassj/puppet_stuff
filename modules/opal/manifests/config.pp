class opal::config ($config){
  file{'/etc/opal/opal-config.properties':
    ensure => file,
    owner  => 'opal',
    group  => 'adm',
    source => $config,
    mode   => 750
  }
}
