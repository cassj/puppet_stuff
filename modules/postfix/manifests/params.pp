class postfix::params {

  case $operatingsystem {
    /(Ubuntu|Debian)/:{
      $pkg_name = ['postfix','bsd-mailx']
    }
    /(RedHat|CentOS|Fedora|Scientific)/:{
      $pkg_name = ['postfix','mailx']
    }
  }


   $cfg_master = '/etc/postfix/master.cf'
   $cfg_main   = '/etc/postfix/main.cf'
   $user       = 'postfix'
   $service    = 'postfix'
}
