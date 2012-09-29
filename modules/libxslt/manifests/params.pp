class libxslt::params {
  case $operatingsystem {
    /(Ubuntu|Debian)/:{
      $dev_pkg_name = 'libxslt-dev'
    }
    /(RedHat|CentOS|Fedora|Scientific)/:{
      $dev_pkg_name = 'libxslt-devel'
    }
  }
}
