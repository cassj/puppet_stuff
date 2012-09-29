class readline::params {
  case $operatingsystem {
    /(Ubuntu|Debian)/:{
      $dev_pkg_name = 'libreadline6-dev'
    }
    /(RedHat|CentOS|Fedora|Scientific)/:{
      $dev_pkg_name = 'readline6-devel'
    }
  }
}
