class aide::params {
  case $operatingsystem {
    /(Ubuntu|Debian)/:{
      $pkg_name = 'aide'
    }
    /(RedHat|CentOS|Fedora|Scientific)/:{
      $pkg_name = 'aide'
    }
  }
 
}
