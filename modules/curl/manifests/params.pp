class curl::params {
  case $operatingsystem {
    /(Ubuntu|Debian)/:{
      $pkg_name = 'curl'
      $dev_pkg_name = 'libcurl4-openssl-dev'
    }
    /(RedHat|CentOS|Fedora|Scientific)/:{
      $pkg_name = 'curl'
      $dev_pkg_name = 'libcurl-devel'
    }
  }
 
}
