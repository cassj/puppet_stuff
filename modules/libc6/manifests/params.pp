class libc6::params {
  case $operatingsystem {
    /(Ubuntu|Debian)/:{
      $pkg_name = 'libc6'
      $dev_pkg_name = 'libc6-dev'
    }
    /(RedHat|CentOS|Fedora|Scientific)/:{
       fail 'pacakge not available for RHEL flavours'
    }
  }
}
