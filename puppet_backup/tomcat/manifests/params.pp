class tomcat::params {
  #for rhel6
  $path          = '/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin'
  $pkgname       = ['tomcat6','tomcat6-admin-webapps']
  $service       = 'tomcat6'
  $port          = 8080
  $user          = 'tomcat'
  $group         = 'tomcat'
  $cfg_file      = '/etc/tomcat6/tomcat6.conf'
  $user_file     = '/etc/tomcat6/tomcat-users.xml'
  $catalina_home = '/usr/share/tomcat6'
  $catalina_base = '/usr/share/tomcat6'
}
