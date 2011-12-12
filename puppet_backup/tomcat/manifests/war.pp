define tomcat::war ($appname, $warfile){


# don't use this, just use utils::download_file

  include tomcat

  file { "$tomcat::params::catalina_base/webapps/$appname"
    ensure  => directory,
    recurse => true,
    purge   => true,
    owner   => 'tomcat',
    group   => 'tomcat',
    mode    => 700
  }


  file { "$tomcat::params::catalina_base/webapps/$appname.war" :
    content => $warfile,
    owner   => 'tomcat',
    group   => 'tomcat',
    mode    => 700,
    require => Class['tomcat::install'],
    notify  => "$tomcat::params::catalina_base/webapps/$appname",
    notify  => Class['tomcat::service']
  }

}
