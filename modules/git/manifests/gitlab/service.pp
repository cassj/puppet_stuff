class git::gitlab::service {
  service{'gitlab':
    ensure     => running,
    hasstatus  => true,
    hasrestart => true,
    enable     => true,
    require    => Class['git::gitlab'],
  }
}
