class postfix::service{
  service { $postfix::params::service:
    ensure     => running,
    hasstatus  => true,
    hasrestart => true,
    enable     => true,
    require    => Class['postfix::config']
  }
}
