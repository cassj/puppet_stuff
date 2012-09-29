class ssl::params {
  case $operatingsystem {
    /(Ubuntu|Debian)/:{
      $pkg_name = 'openssl'
      $dev_pkg_name = 'libssl-dev'
    }
    /(RedHat|CentOS|Fedora|Scientific)/:{
      $pkg_name = 'openssl'
      $dev_pkg_name = 'openssl-devel'
    }
  }
}
