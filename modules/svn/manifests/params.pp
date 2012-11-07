class svn::params {
  case $operatingsystem {
    /(Ubuntu|Debian)/:{
      $pkg_name = 'subversion'
    }
    /(RedHat|CentOS|Fedora|Scientific)/:{
      $pkg_name = 'subversion'
    }
  }
}
