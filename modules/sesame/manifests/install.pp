class sesame::install{

  include sesame::params

  file{'/opt/sesame':
    ensure => directory,
    owner  => 'root',
    group  => 'root'
  }

  # get the install file
  file{"/opt/sesame/$sesame::params::installfile":
    ensure => present, 
    owner  => 'root',
    group  => 'root',
    source => "puppet:///modules/sesame/$sesame::params::installfile",
    require => File['/opt/sesame']
  }

  # unpack it 
  utils::tar::untar_file{"/opt/sesame/$sesame::params::installfile":
    file        => $sesame::params::installfile,
    cwd         => "/opt/sesame",
    user        => 'root',
    group       => 'root',
    gzip_filter => true,
    creates     => "/opt/sesame/$unpackedfile",
    require     => File["/opt/sesame/$sesame::params::installfile"]
  }

  # move the war files over to the tomcat dir.
  exec{'copy-sesame-war':
    command => '/bin/cp /opt/sesame/openrdf-*/war/*.war /usr/share/tomcat6/webapps',
    subscribe => Utils::Tar::Untar_file["/opt/sesame/$sesame::params::installfile"],
    refreshonly => true
  }
  exec{'chown-sesame-war':
    command     => '/bin/chown tomcat:tomcat /usr/share/tomcat6/webapps/*',
    subscribe   => Exec['copy-sesame-war'],
    notify      => Class['tomcat::service'],
    refreshonly => true   
   }

}
