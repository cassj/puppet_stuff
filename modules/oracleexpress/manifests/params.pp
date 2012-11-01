class oracleexpress::params {
  case $operatingsystem {
    /(Ubuntu|Debian)/:{
      fail('package not available for debian distros') 
    }
    /(RedHat|CentOS|Fedora|Scientific)/:{
    }
  }
}
