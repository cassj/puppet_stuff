class tomcat::install{

  include tomcat::params
  require 'ant' 

  package {$tomcat::params::pkgname:
    ensure => latest
  }

  # and add a profile.d file to set JAVA_HOME appropriately
  file{'/etc/profile.d/tomcat.sh':
    ensure  => file,
    owner   => 'root',
    group   => 'root',
    mode    => '644',
    content => "export CATALINA_HOME='$tomcat::params::catalina_home'\nexport CATALINA_BASE=$tomcat::params::catalina_base\n"
  }
  file{'/etc/profile.d/tomcat.csh':
    ensure  => file,
    owner   => 'root',
    group   => 'root',
    mode    => 644,
    content => "setenv CATALINA_HOME $tomcat::params::catalina_home\nsetenv CATALINA_BASE $tomcat::params::catalina_base"
  }

}
