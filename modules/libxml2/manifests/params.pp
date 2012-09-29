class libxml2::params {
  case $operatingsystem {
    /(Ubuntu|Debian)/:{
      $pkg_name = 'libxml2'
      $dev_pkg_name = 'libxml2-dev'
    }
    /(RedHat|CentOS|Fedora|Scientific)/:{
      $pkg_name = 'libxml2'
      $dev_pkg_name = 'libxml2-devel'
    }
  }
}
