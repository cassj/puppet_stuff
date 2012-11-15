class opal::service {
  service{ opal:
    ensure     => running,
    hasstatus  => true,
    hasrestart => true,
    enable     => true,
    require    => Class['opal::install'],
    subscribe  => Class['opal::config']
  }
  exec{'opalrcd':
    command => '/bin/ln -s ../init.d/opal S20opal',
    creates => '/etc/rc5.d/S20opal',
    cwd     => '/etc/rc5.d'

  }

}
