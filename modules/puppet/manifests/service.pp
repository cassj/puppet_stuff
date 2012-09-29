class puppet::service {

  service {'puppet':
    ensure => running,
    hasstatus => true,
    enable => true,
    require => Class['puppet::install']
  }

}
