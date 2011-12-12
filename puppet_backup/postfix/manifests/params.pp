class ssh::params {
   $pkg_name   = ['postfix', 'mailx']
   $cfg_master = '/etc/postfix/master.cf'
   $cfg_main   = '/etc/postfix/main.cf'
   $user       = 'postfix'
   $service    = 'postfix'
}
