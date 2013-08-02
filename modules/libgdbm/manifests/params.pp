class libgdbm::params {
  case $operatingsystem {
    /(Ubuntu|Debian)/:{
      $pkg_name = 'libgdbm3'
      $dev_pkg_name = 'libgdbm-dev'
    }
    /(RedHat|CentOS|Fedora|Scientific)/:{
      $pkg_name = 'gdbm'
      $dev_pkg_name = 'gdbm-devel'
    }
  }
}
