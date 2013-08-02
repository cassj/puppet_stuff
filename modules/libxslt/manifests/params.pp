class libxslt::params {
  case $operatingsystem {
    /(Ubuntu|Debian)/:{
      $pkg_name = 'libxslt1.1'
      $dev_pkg_name = 'libxslt1-dev'
    }
    /(RedHat|CentOS|Fedora|Scientific)/:{
      $pkg_name = 'libxslt'
      $dev_pkg_name = 'libxslt-devel'
    }
  }
}
