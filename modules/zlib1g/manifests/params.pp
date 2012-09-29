class zlib1g::params {
  case $operatingsystem {
    /(Ubuntu|Debian)/:{
      $pkg_name = 'zlib1g'
      $dev_pkg_name = 'zlib1g-dev'
    }
    /(RedHat|CentOS|Fedora|Scientific)/:{
      $pkg_name = 'zlib'
      $dev_pkg_name = 'zlib-devel'
    }
  }
}
