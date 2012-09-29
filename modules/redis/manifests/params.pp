class redis::params {
  case $operatingsystem {
    /(Ubuntu|Debian)/:{
      $pkg_name = 'redis-server'
    }
    /(RedHat|CentOS|Fedora|Scientific)/:{
      $pkg_name = 'redis'
    }
  }
}
