class bind::params {
  case $operatingsystem {
    Solaris : {
      $pkg_name = 'bind'
      $cfg_file = '/etc/named.conf'
      $service  = 'bind'
    }
    /(Ubuntu|Debian)/:{
      $pkg_name = 'bind'
      $cfg_file = '/etc/bind/named.conf'
      $service  = 'bind'
    }
    /(RedHat|CentOS|Fedora|Scientific)/:{
      $pkg_name = 'bind'
      $cfg_file = '/etc/named.conf'
      $service  = 'bind'
    }
  }
}
