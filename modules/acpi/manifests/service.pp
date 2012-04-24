class acpid::service {
  service { $acpid::params::service:
    ensure     => running,
    hasstatus  => true,
    hasrestart => true,
    enable     => true,
    require    => Class['acpid::install']
  }
}

