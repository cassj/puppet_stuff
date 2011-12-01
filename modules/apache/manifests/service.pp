class apache::service {
  service { $apache::params::service:
    ensure     => running,
    hasstatus  => true,
    hasrestart => true,
    enable     => true,
    require    => Class['apache::install']
  }
}

