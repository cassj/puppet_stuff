class libffi::params {
  case $operatingsystem {
    /(Ubuntu|Debian)/:{
      $pkg_name = 'libffi5'
      $dev_pkg_name = 'libffi-dev'
    }
    /(RedHat|CentOS|Fedora|Scientific)/:{
      $pkg_name = 'libffi'
      $dev_pkg_name = 'libffi-devel'
    }
  }
}
