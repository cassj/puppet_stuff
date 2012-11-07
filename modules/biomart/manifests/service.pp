class ssh::service {
  service{ $ssh::params::service:
    ensure     => running,
    hasstatus  => true,
    hasrestart => true,
    enable     => true,
    require    => Class['ssh::config'],
  }
}
