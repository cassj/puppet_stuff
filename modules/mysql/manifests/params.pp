class mysql::params {

  $path = '/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin'

  # If you need to use an alternative version of mysql to the one in the path
  # change this to the full path to its location
  $cmd ='mysql' 

  case $operatingsystem {
    Solaris : {
      $pkg_name   = ['mysql5','mysql5client', 'mysql5rt','mysql5test','mysql5devel']
      $cfg_file   = '/opt/csw/mysql5/my.cnf'
      $var_dir    = '/opt/csw/mysql5/var'
      $service    = 'mysqld'
      $user       = 'mysql'
      $shell      = '/bin/false'
    }
    /(Ubuntu|Debian)/:{
      $pkg_name   = ['mysql-client','mysql-server', 'libmysqlclient-dev']
      $cfg_file   = '/etc/mysql/my.cnf'
      $var_dir    = '/var/lib/mysql'
      $service    = 'mysql'
      $user       = 'mysql'
      $shell      = '/bin/false'
    }
    /(RedHat|CentOS|Fedora|Scientific)/:{
      $pkg_name = ['mysql', 'mysql-server','mysql-devel']
      $cfg_file = '/etc/my.cnf' 
      $var_dir  = '/var/lib/mysql'
      $service  = 'mysqld'
      $user     = 'mysql'
      $shell    = '/bin/nologin'
    }
  }
}
