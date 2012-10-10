class opal::service {
  service{ opal:
    ensure     => running,
    hasstatus  => true,
    hasrestart => true,
    enable     => true,
    require    => Class['opal::install'],
    subscribe  => Class['opal::config']
  }
}
