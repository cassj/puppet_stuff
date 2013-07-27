class tomcat::params {

  $path          = '/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin'

  case $operatingsystem {
    /(Ubuntu|Debian)/:{
      $pkgname       = ['tomcat6']
      $service       = 'tomcat6'
      $port          = 8080
      $user          = 'tomcat6'
      $group         = 'tomcat6'
      $cfg_file      = '/etc/tomcat6/tomcat6.conf'
      $user_file     = '/etc/tomcat6/tomcat-users.xml'
      $catalina_home = '/usr/share/tomcat6'
      $catalina_base = '/usr/share/tomcat6'
    }
    /(RedHat|CentOS|Fedora|Scientific)/:{
      $pkgname       = ['tomcat6']
      $service       = 'tomcat6'
      $port          = 8080
      $user          = 'tomcat'
      $group         = 'tomcat'
      $cfg_file      = '/etc/tomcat6/tomcat6.conf'
      $user_file     = '/etc/tomcat6/tomcat-users.xml'
      $catalina_home = '/usr/share/tomcat6'
      $catalina_base = '/usr/share/tomcat6'
    }
  }
  
}
