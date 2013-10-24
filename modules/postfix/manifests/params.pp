class postfix::params {

  case $operatingsystem {
    /(Ubuntu|Debian)/:{
      $pkg_name = ['postfix','bsd-mailx']
    }
    /(RedHat|CentOS|Fedora|Scientific)/:{
      $pkg_name = ['postfix','mailx']
    }
  }


   $dir        = '/etc/postfix'
   $cfg_master = "$dir/master.cf"
   $cfg_main   = "$dir/main.cf"
   $user       = 'postfix'
   $service    = 'postfix'
}
