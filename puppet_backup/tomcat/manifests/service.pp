class tomcat::service {

  include tomcat::params

  service { $tomcat::params::service:
    ensure     => running,
    hasstatus  => true,
    hasrestart => true,
    enable     => true,
    require    => Class['tomcat::install']
  }
 

}
