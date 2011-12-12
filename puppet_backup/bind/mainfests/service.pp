class bind::service {
  service{ $bind::params::service:
    ensure     => running,
    hasstatus  => true,
    hasrestart => true,
    enable     => true,
    require    => Class['bind::config'],
  }
}
