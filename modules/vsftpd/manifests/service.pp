class vsftpd::service {
  service{ $vsftpd::params::service:
    ensure     => running,
    hasstatus  => true,
    hasrestart => true,
    enable     => true,
    require    => Class['vsftpd::config'],
  }
}
