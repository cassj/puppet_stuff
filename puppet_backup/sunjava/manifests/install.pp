class sunjava::install{

  include sunjava::params

  Exec{path => $sunjava::params::path }

  file {"/root/$sunjava::params::rpmfile":
    ensure => file,
    source => "puppet:///modules/sunjava/$sunjava::params::rpmfile",
    owner  => 'root',
    group  => 'root',
    mode   => 600
  }

  exec {"sunjava-rpm-install":
    unless   => "rpm -qa | grep ^jdk",
    command  => "rpm --install /root/$sunjava::params::rpmfile",
    require  => File["/root/$sunjava::params::rpmfile"]
  }

  exec {"sunjava-rpm-alternatives":
    command  => "/usr/sbin/alternatives --install /usr/bin/java java /usr/java/default/bin/java 20000",
    require  => Exec['sunjava-rpm-install'],    
  }

  exec{"sunjava-browser-alternatives":
    onlyif  => "test -d /usr/lib/mozilla/plugins",
    command => "/usr/sbin/alternatives --install /usr/lib/mozilla/plugins/libjavaplugin.so libjavaplugin.so /usr/java/default/jre/lib/i386/libnpjp2.so 20000",
    require => Exec["sunjava-rpm-alternatives"]
  }

  $javacmd = "export JAVA_HOME=$sunjava::params::java_home
export LD_LIBRARY_PATH=$sunjava::params::java_home"
  file{"/etc/profile.d/sunjava.sh":
    owner   => 'root',
    group   => 'root',
    mode    => 644,
    content => $javacmd
  }


  package{"$sunjava::params::antpkg":
    ensure => installed 
  }

}
