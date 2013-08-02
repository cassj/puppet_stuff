class checkinstall::params {
  
  case $operatingsystem {
    /(Ubuntu|Debian)/:{
      $pkg_name = 'checkinstall'
    }
    default: { fail("${::hostname}: Module ${::module_name} does not support operatingsystem ${::operatingsystem}") }
  }
}
