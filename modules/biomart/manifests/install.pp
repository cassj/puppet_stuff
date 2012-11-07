class biomart::install ($version){
  
  
  # create biomart group
  group{'biomart':
    ensure => present
  }

  # create biomart user
  user {'biomart':
    ensure => present,
    gid    => 'biomart',
    shell  => '/bin/bash'
  }

  # create install dir
  file {'/opt/biomart':
    ensure => directory,
    owner  => 'biomart',
    group  => 'biomart',
    mode   => '755'
  }


  # checkout repos
  exec {'checkout-biomart-svn':
    command => "/usr/bin/svn checkout https://code.oicr.on.ca/svn/biomart/biomart-java/branches/$version/",
    cwd     => "/opt/biomart/",
    creates => "/opt/biomart/$version",
    require => Class['svn']
  }
 
  # run ant to build biomart
  exec {'build-biomart':
    command     => '/usr/bin/ant',
    cwd         => "/opt/biomart/$version",
    require     => Class['sunjava','ant'],
    refreshonly => true,
    subscribe   => Exec['checkout-biomart-svn']
  }
 
  
  
}
