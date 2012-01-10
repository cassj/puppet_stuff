class sunjava::install{

  include sunjava::params

  Exec{path => $sunjava::params::path }

  package{$sunjava::params::pkg_name:
    ensure => present
  }
 

# make this your default java
exec {"sunjava-java-alternatives":
  command  => "/usr/sbin/alternatives --install /usr/bin/java java /usr/java/latest/jre/bin/java 20000",
  require  => Package[$sunjava::params::pkg_name],    
}

# and your default javaws
exec {"sunjava-javaws-alternatives":
  command => "/usr/sbin/alternatives --install /usr/bin/javaws javaws /usr/java/latest/jre/bin/javaws 20000",
  require  => Package[$sunjava::params::pkg_name],    
}

#and javac
exec {"sunjava-javac-alternatives":
  command => "/usr/sbin/alternatives --install /usr/bin/javac javac /usr/java/latest/bin/javac 20000",
  require  => Package[$sunjava::params::pkg_name],    
}

#and jar
exec{"sunjava-jar-alternatives":
  command => "/usr/sbin/alternatives --install /usr/bin/jar jar /usr/java/latest/bin/jar 20000",
  require  => Package[$sunjava::params::pkg_name],    
}

# and if you have mozilla installed, add the plugin
exec{"sunjava-mozilla-alternatives":
  onlyif  => "test -d /usr/lib/mozilla/plugins",
  command => "/usr/sbin/alternatives --install /usr/lib/mozilla/plugins/libjavaplugin.so libjavaplugin.so /usr/java/latest/jre/lib/i386/libnpjp2.so 20000",
  require  => Package[$sunjava::params::pkg_name],    
}

exec{"sunjava-mozilla64-alternatives":
  onlyif  => "test -d /usr/lib64/mozilla/plugins",
  command => "/usr/sbin/alternatives --install /usr/lib64/mozilla/plugins/libjavaplugin.so libjavaplugin.so.x86_64 /usr/java/latest/jre/lib/amd64/libnpjp2.so 20000",
  require  => Package[$sunjava::params::pkg_name]    
}





#$javacmd = "export JAVA_HOME=$sunjava::params::java_home
#export LD_LIBRARY_PATH=$sunjava::params::java_home"
#  file{"/etc/profile.d/sunjava.sh":
#    owner   => 'root',
#    group   => 'root',
#    mode    => 644,
#    content => $javacmd
#  }

#
#  package{"$sunjava::params::antpkg":
#    ensure => installed 
#  }
#
}
