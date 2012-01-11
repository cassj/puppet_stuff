class iscsi::service {
  service { $iscsi::params::service:
    ensure     => running,
    hasstatus  => true,
    hasrestart => true,
    enable     => true,
    require    => Class['iscsi::install']
  }
}

