class yaml::params {
  case $operatingsystem {
    /(Ubuntu|Debian)/:{
      $pkg_name = 'libyaml-0-2'
      $dev_pkg_name = 'libyaml-dev'
    }
    /(RedHat|CentOS|Fedora|Scientific)/:{
      $pkg_name = 'libyaml'
      $dev_pkg_name = 'libyaml-devel'
    }
  }
}
