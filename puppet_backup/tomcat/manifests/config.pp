class tomcat::config {

  include tomcat::params

  file {"$tomcat::params::catalina_base":
     ensure  => directory,
      recurse => true,
     owner   => $tomcat::params::user,
     group   => $tomcat::params::group
   }

  file {$tomcat::params::cfg_file:
    ensure   => present,
    owner    => $tomcat::params::user,
    group    => $tomcat::params::group,
    source   => "puppet:///modules/tomcat/tomcat6.conf",
    require  => Class['tomcat::install'],
    notify   => Class['tomcat::service']
  }

  file{$tomcat::params::user_file:
    ensure  => present,
    owner   => $tomcat::params::user,
    group   => $tomcat::params::group,
    source  => "puppet:///modules/tomcat/tomcat-users.xml",
    require => Class['tomcat::install'],
    notify  => Class['tomcat::service']
  }
  
}
