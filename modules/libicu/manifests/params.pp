class libicu::params {
  case $operatingsystem {
    /(Ubuntu|Debian)/:{
      $pkg_name = 'libicu48'
      $dev_pkg_name = 'libicu-dev'
    }
    /(RedHat|CentOS|Fedora|Scientific)/:{
      $pkg_name = 'libicu'
      $dev_pkg_name = 'libicu-devel'
    }
  }
}
