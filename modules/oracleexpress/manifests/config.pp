class oracleexpress::config ($config) {
  
  # upoad the profile.d files
  file {'/etc/profile.d/oracle-xe.sh':
    ensure => file,
    owner  => 'root',
    group  => 'root',
    mode   => 755,
    source => 'puppet:///modules/oracleexpress/oracle-xe.sh'
  }

  file {'/etc/profile.d/oracle-xe.csh':
    ensure => file,
    owner  => 'root',
    group  => 'root',
    mode   => 755,
    source => 'puppet:///modules/oracleexpress/oracle-xe.csh'
  }

 
  # upload the config file
  file {'/root/xe.rsp':
    ensure => file,
    owner  => 'root',
    group  => 'root',
    mode   => '700',
    source => $config
  }

  exec{'xe-config':
    command => '/etc/init.d/oracle-xe configure responseFile=/root/xe.rsp >> /root/xe-install.log',
    refreshonly => true,
    subscribe => File['/root/xe.rsp'],
    require => [Class['oracleexpress::install'], File['/root/xe.rsp']]
  } 

  # You should now be able to run sqlplus from cli and login as
  # SYSTEM with the password defined in the xe.rsp file.

  # To allow users to log into the web interface from other machines
  # than the local one, you will need to run
  # EXEC DBMS_XDB.SETLISTENERLOCALACCESS(FALSE); 
  # 
}
