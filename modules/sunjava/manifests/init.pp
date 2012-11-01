class sunjava{
 
  file{'/tmp/jdk-7u7-linux-x64.rpm':
    ensure => file,
    owner  => 'root',
    group  => 'root',
    mode   => '755',
    source => 'puppet:///modules/sunjava/jdk-7u7-linux-x64.rpm'
  }
  exec{'install-sunjava':
    command  => '/bin/rpm -i /tmp/jdk-7u7-linux-x64.rpm',
    unless   => '/bin/rpm -qa | /bin/grep jdk',
    require  => File['/tmp/jdk-7u7-linux-x64.rpm'],
    subscribe => File['/tmp/jdk-7u7-linux-x64.rpm']
  }
 
  # link this version to /usr/java/latest
  file{'/usr/java':
    ensure => directory,
    owner  => 'root',
    group  => 'root',
    mode   => 755
  }
  exec{'set-sunjava-latest':
    command     => '/bin/ln -sf /usr/java/jdk1.7.0_07 /usr/java/latest',
    subscribe   => Exec['install-sunjava'],
    creates     => '/usr/java/latest',
    require     => File['/usr/java']
  }


  # make this your default java
  exec {"sunjava-java-alternatives":
    command     => "/usr/sbin/alternatives --install /usr/bin/java java /usr/java/latest/jre/bin/java  20000",
    require     => Exec['set-sunjava-latest'],
    refreshonly => true
  }
  
  # and your default javaws
  exec {"sunjava-javaws-alternatives":
    command     => "/usr/sbin/alternatives --install /usr/bin/javaws javaws /usr/java/latest/jre/bin/javaws 20000",
    require     => Exec['set-sunjava-latest'],
    refreshonly => true
  }
  
  #and javac
  exec {"sunjava-javac-alternatives":
    command     => "/usr/sbin/alternatives --install /usr/bin/javac javac /usr/java/latest/bin/javac 20000",
    require     => Exec['set-sunjava-latest'],
    refreshonly => true
  }
  
  #and jar
  exec{"sunjava-jar-alternatives":
    command     => "/usr/sbin/alternatives --install /usr/bin/jar jar /usr/java/latest/bin/jar 20000",
    require     => Exec['set-sunjava-latest'],
    refreshonly => true
  }
  
  # and if you have mozilla installed, add the plugin
  exec{"sunjava-mozilla-alternatives":
    onlyif      => "/usr/bin/test -d /usr/lib/mozilla/plugins",
    command     => "/usr/sbin/alternatives --install /usr/lib/mozilla/plugins/libjavaplugin.so libjavaplugin.so /usr/java/latest/jre/lib/i386/libnpjp2.so 20000",
    require     => Exec['set-sunjava-latest'],
    refreshonly => true
  }
  
  
  exec{"sunjava-mozilla64-alternatives":
    onlyif      => "/usr/bin/test -d /usr/lib64/mozilla/plugins",
    command     => "/usr/sbin/alternatives --install /usr/lib64/mozilla/plugins/libjavaplugin.so libjavaplugin.so.x86_64 /usr/java/latest/jre/lib/amd64/libnpjp2.so 20000",
    require     => Exec['set-sunjava-latest'],
    refreshonly => true
  }

  # and add a profile.d file to set JAVA_HOME appropriately
  file{'/etc/profile.d/java.sh':
    ensure  => file,
    owner   => 'root',
    group   => 'root',
    mode    => '644',
    content => "export JAVA_HOME='/usr/java/latest'\nexport PATH=\$JAVA_HOME/bin:\$PATH\n"
  }
  file{'/etc/profile.d/java.csh':
    ensure  => file,
    owner   => 'root',
    group   => 'root',
    mode    => 644,
    content => "setenv JAVA_HOME /usr/java/latest\nsetenv PATH \$JAVA_HOME/bin:\$PATH"
  }


}
