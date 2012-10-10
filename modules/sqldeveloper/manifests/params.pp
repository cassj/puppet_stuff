class sqldeveloper::params {
  case $operatingsystem {
    /(Ubuntu|Debian)/:{
     fail('package not available for debian distros') 
    }
    /(RedHat|CentOS|Fedora|Scientific)/:{
      $pkg_name = 'sqldeveloper'
    }
  }
}
