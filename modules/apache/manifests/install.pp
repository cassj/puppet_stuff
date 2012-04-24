class apache::install {
  package{ $apache::params::pkg_name:
    ensure => present 
  }

  # allow apache to send mail
  exec{'/usr/sbin/setsebool -P httpd_can_sendmail on':}

}
