class libmysqlplusplus::params {
  case $operatingsystem {
    /(Ubuntu|Debian)/:{
      $pkg_name = 'libmysql++3'
      $dev_pkg_name = 'libmysql++-dev'
    }
    /(RedHat|CentOS|Fedora|Scientific)/:{
      $pkg_name = 'mysql++'
      $dev_pkg_name = 'mysql++-devel'
    }
  }
}
