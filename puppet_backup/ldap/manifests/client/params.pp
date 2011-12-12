class ldap::client::params ($host_ip, $dn, $key){

  $path =  '/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin'

   # OS specific settings
  case $operatingsystem {
    Solaris : {
    }
    /(Ubuntu|Debian)/:{
    }
    /(RedHat|CentOS|Fedora|Scientific)/:{
      $pkg_name  = 'openldap-clients'
      $cfg_file  = '/etc/openldap/ldap.conf'
      $user = 'ldap'
      $group = 'ldap'
    }
  }
 
}
