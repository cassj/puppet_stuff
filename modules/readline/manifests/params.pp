class readline::params {
  case $operatingsystem {
    /(Ubuntu|Debian)/:{
      $pkg_name = "libreadline6"
      $dev_pkg_name = 'libreadline6-dev'
    }
    /(RedHat|CentOS|Fedora|Scientific)/:{
      $pkg_name = 'readline'
      $dev_pkg_name = 'readline6-devel'
    }
  }
}
