class ncurses::params {
  case $operatingsystem {
    /(Ubuntu|Debian)/:{
      $pkg_name = "libncurses5"
      $dev_pkg_name = 'libncurses5-dev'
    }
    /(RedHat|CentOS|Fedora|Scientific)/:{
      $pkg_name = 'ncurses'
      $dev_pkg_name = 'ncurses-devel'
    }
  }
}
