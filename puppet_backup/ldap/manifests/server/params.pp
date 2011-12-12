class ldap::server::params ($password, $dn, $slapdcert='/etc/pki/tls/certs/slapdcert.pem', $slapdkey='/etc/pki/tls/certs/slapdkey.pem') {

  include ftp::server::params

  $path            = '/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin'

  $ssl_out    = '/etc/pki/tls/certs/slapdcert.pem'
  $ssl_keyout = '/etc/pki/tls/certs/slapdkey.pem'
  $ssl_days   = '365'
 
  $key_ftp    =  "$ftp::server::params::pubdir/slapdkey.pem"


  # OS specific settings
  case $operatingsystem {
    Solaris : {
#      $pkg_name = 'openssh'
#      $cfg_file = '/etc/ssh/sshd_config'
#      $ldif_dir = ''
#      $service  = 'sshd'
    }
    /(Ubuntu|Debian)/:{
#      $pkg_name = 'openssh-server'
#      $cfg_file = '/etc/ssh/sshd_config'
#      $ldif_dir = ''
#      $service  = 'sshd'
    }
    /(RedHat|CentOS|Fedora|Scientific)/:{
      $pkg_name  = 'openldap-servers'
      $cfg_file  = '/etc/openldap/ldap.conf'
      $ldif_dir = '/etc/openldap/slapd.d'
      $bdb_ldif_file = '/etc/openldap/slapd.d/cn=config/olcDatabase={1}bdb.ldif' 
      $monitor_ldif_file = '/etc/openldap/slapd.d/cn=config/olcDatabase={2}monitor.ldif'
      $sysconfig_file = '/etc/sysconfig/ldap'
      $service   = 'slapd'
      $user = 'ldap'
      $group = 'ldap'
      $ldap_dir = '/var/lib/ldap'
    }
  }
}
