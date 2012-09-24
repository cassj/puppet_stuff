class rsync::params {
  case $operatingsystem {
    /(Ubuntu|Debian)/:{
      $pkg_name = 'rsync'
    }
    /(RedHat|CentOS|Fedora|Scientific)/:{
      $pkg_name = 'rsync'
    }
  }
}
