class vsftpd::params {
  case $operatingsystem {
    /(RedHat|CentOS|Fedora|Scientific)/:{
      $pkg_name = 'vsftpd'
      $cfg_file = '/etc/vsftpd/vsftpd.conf'
      $service  = 'vsftpd'
    }
  }
}
