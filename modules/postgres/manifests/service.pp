class postgres::service {

  include postgres::params

  service { $postgres::params::service:
    ensure     => running,
    hasstatus  => true,
    hasrestart => true,
    enable     => true,
    require    => Class['postgres::install']
  }


}
