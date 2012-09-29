class sqlite::params {
  case $operatingsystem {
    /(Ubuntu|Debian)/:{
      $pkg_name = 'sqlite3'
      $dev_pkg_name = 'libsqlite3-dev'
    }
    /(RedHat|CentOS|Fedora|Scientific)/:{
      $pkg_name = 'sqlite'
      $dev_pkg_name = 'sqlite-devel'
    }
  }
}
