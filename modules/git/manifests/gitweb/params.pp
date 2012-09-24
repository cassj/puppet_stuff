class git::gitweb::params {
  case $operatingsystem {
    /(Ubuntu|Debian)/:{
      $pkg_name = 'gitweb'
    }
    /(RedHat|CentOS|Fedora|Scientific)/:{
      $pkg_name = 'gitweb'
    }
  }
}
