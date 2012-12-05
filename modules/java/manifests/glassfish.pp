class sunjava::glassfish{

  include java::params, java, utils::zip
 
  Exec{ path => $java::params::path }

  file {"/root/$java::params::glassfishfile":
    ensure => file,
    source => "puppet:///modules/java/$java::params::glassfishfile",
    owner  => 'root',
    group  => 'root',
    mode   => 600
  }

  file {"$sunjava::params::glassfishdir":
    ensure => directory
  }

  # aaaaaaaaaaaaaaaaaagh. I *hate* all things java. 
  # this needs you to manually accept their stupid T&C. 
  file{"/tmp/accept.txt":
    content => "A\n",
  }
  exec {'sunjava-glassfish-jar-install':
    cwd     => $sunjava::params::glassfishdir,
    command => "java -Xmx256m -jar /root/$sunjava::params::glassfishfile < /tmp/accept.txt",
    creates => "$sunjava::params::glassfishdir/glassfish",
    require => [ File["/root/$sunjava::params::glassfishfile"], File["$sunjava::params::glassfishdir"],File["/tmp/accept.txt"] ]
  }

  exec{'sunjava-glassfish-setupscript':
    cwd     => "$sunjava::params::glassfishdir/glassfish",
    command => "ant -f setup.xml",
    creates => "/$sunjava::params::glassfishdir/glassfish/domains/domain1",
    require => Exec['sunjava-glassfish-jar-install']
  }

#  #to get this to work with ant we need to set some environment variables
#  file{'/etc/profile.d/glassfish.sh':
#    ensure => file,
#    owner  => 'root',
#    group  => 'root',
#    source => 'puppet:///modules/sunjava/glassfish.sh' 
#  }
#
#  file{'/etc/profile.d/glassfish.csh':
#    ensure => file,
#    owner  => 'root',
#    group  => 'root',
#    source => 'puppet:///modules/sunjava/glassfish.csh'
#  }


  
}
