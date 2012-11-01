class apache::install {
  package{ $apache::params::pkg_name:
    ensure => present 
  }

  if ($selinux == true){
    # allow apache to send mail
    exec{'/usr/sbin/setsebool -P httpd_can_sendmail on':
      unless => '/bin/grep -q "1" /selinux/booleans/httpd_can_network_connect_db '
    }
  }

}
