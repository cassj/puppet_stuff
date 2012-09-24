class git::params {
  case $operatingsystem {
    /(Ubuntu|Debian)/:{
      $pkg_name = 'git-core'
    }
    /(RedHat|CentOS|Fedora|Scientific)/:{
      $pkg_name = 'git-core'
    }
  }
}
