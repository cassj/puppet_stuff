class ruby19::params {

  case $operatingsystem {
    /(Ubuntu|Debian)/:{
      $pkg_name = 'ruby1.9.1'
      #$gems_pkg_name
      #$gems_bin
    }
    default: { fail("${::hostname}: Module ${::module_name} does not support operatingsystem ${::operatingsystem}") }
  }


}
