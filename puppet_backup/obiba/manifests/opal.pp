class obiba::opal (
  $obiba_user, 
  $obiba_group, 
  $obiba_home,
  $db_user,
  $keydb_user,
  $db_pass,
  $keydb_pass,
  $db,
  $keydb,
  $admin_user,
  $admin_pass,
  $mysql_root_pass = ""
) {

  include obiba::params

  Exec { path => $obiba::params::path }

  Class['mysql']->Class['obiba::opal']

  $dlfile    = $obiba::params::opal_dlfile
  $site      = $obiba::params::opal_site  
  $serverdir = $obiba::params::opal_serverdir
  $opalhome  = "$obiba_home/opal/$serverdir"

 
  file {"$obiba_home/opal":
    ensure  => directory,
    recurse => true,
    owner   =>  'root',
    group   => 'root',
    mode    => 770,
    require => Class['obiba::common'],
  }

  file {"$obiba_home/opal/download":
    ensure  => directory,
    owner   => 'root',
    group   => 'root',
    mode    => 770,
    require => File["$home/opal"],
  }

  utils::download_file {$dlfile:   
    site      => $site,
    cwd       => "$obiba_home/opal/download",
    creates   => "$obiba_home/opal/download/$name",
    require   => File["$obiba_home/opal/download"],
    user      => 'root',
    group     => 'root',
  }

  exec {"$obiba_home/opal/download/$dlfile":
    cwd     => "$obiba_home/opal",
    user    => 'root',
    group   => 'root',
    creates => "$obiba_home/opal/$serverdir",
    command => "unzip $obiba_home/opal/download/$dlfile"
  }

#  utils::zip::unzip_file {$dlfile:
#    cwd      => "$obiba_home/opal/opal-server",
#    creates  => "$obiba_home/opal/opal-server",
#    user     => $obiba_user,
#    group    => 'root',
#    require  => Utils::Download_file[$dlfile]
#  }

  # user authentication file
  file {"$opalhome/conf/shiro.ini":
    ensure  => present,
    owner   => 'root',
    group   => 'root',
    content => template('obiba/opal/shiro.ini.erb'),
    require => Exec["$obiba_home/opal/download/$dlfile"],
  }
  
  # base configuration file
  file {"$opalhome/conf/opal-config.properties":
    ensure   => present,
    owner    => 'root',
    group    => 'root',
    source   => 'puppet:///modules/obiba/opal/opal-config.properties',
    require => Exec["$obiba_home/opal/download/$dlfile"],
  }

#  # main configuration file
  file {"$opalhome/conf/opal-config.xml":
    ensure   => present,
    owner    => 'root',
    group    => 'root',
    source   => 'puppet:///modules/obiba/opal/opal-config.xml',
    require => Exec["$obiba_home/opal/download/$dlfile"],
  }

  # create mysql database, user, give user access
  mysql::database{$db:
   root_password => $mysql_root_pass
  }
  mysql::user{$db_user:
    password      => $db_pass,
    root_password => $mysql_root_pass
  }
  mysql::grant{"$db_user-$db":
    user          => $db_user,
    database      => $db,
    table         => '*',
    priv          => 'ALL',
    root_password => $mysql_root_pass,
    require       => [Mysql::Database[$db], Mysql::User[$keydb_user]]
 }

  mysql::database{$keydb:
    root_password => $mysql_root_pass
  }
  mysql::user{$keydb_user:
    password      => $keydb_pass,
    root_password => $mysql_root_pass
  }
  mysql::grant{"$keydb_user-$keydb":
    user          => $keydb_user,
    database      => $keydb,
    table         => '*',
    priv          => 'ALL',
    root_password => $mysql_root_pass,
    require       => [Mysql::Database[$keydb], Mysql::User[$keydb_user]]
 }


  #open port 8022 for ssh
  $cmd22 = '-I INPUT -p tcp -m tcp --dport 8022 -j ACCEPT'
  exec{'dataverse-port-22':
    unless => "grep $cmd22 /etc/sysconfig/iptables",
    command => "iptables $cmd22; iptables-save > /etc/sysconfig/iptables",
  }
 
  # Note - can't use the default 8080 and 8443 cos we're running Onyx under 
  # tomcat and it uses them, So 8081 8444
  # open port 8081 for http
  $cmd8081 = '-I INPUT -p tcp -m tcp --dport 8081 -j ACCEPT'
  exec{'dataverse-port-8081':
    unless => "grep $cmd8081 /etc/sysconfig/iptables",
    command => "iptables $cmd8081; iptables-save > /etc/sysconfig/iptables",
  }

  # and port 8444 for https
  $cmd8444 = '-I INPUT -p tcp -m tcp --dport 8444 -j ACCEPT'
  exec{'dataverse-port-8444':
    unless => "grep $cmd8444 /etc/sysconfig/iptables",
    command => "iptables $cmd8444; iptables-save > /etc/sysconfig/iptables",
  }











 # This really doesn't work. Will investigate later
 #install the init script and config file which I've nicked from the deb package

 file{'/etc/init.d/opal':
    ensure => absent,
    #source => 'puppet:///modules/obiba/opal/etc-init.d-opal',
    #owner  => $obiba_user,
    #group  => $obiba_group,
    #mode   => 775,
  }

 file {'/etc/default/opal':
   ensure  => absent,
   #source  => 'puppet:///modules/obiba/opal/etc-default-opal',
   #owner   => $obiba_user,
   #group   => $obiba_group,
   #mode    =>  700,
#   notify  => Service['opal']
 }

# service{'opal':
#   ensure     => running,
#   require    => File['/etc/init.d/opal'],
#   hasstart   => true,
#   hasrestart => true,
#   enable     => true
# }
  
 


#  exec {'opal-upgrade':
#    environment => "OPAL_HOME=$opalhome",
#    command => "$opalhome/bin/opal --upgrade",
#    cwd     => "$opalhome",
#    user    => $user,
#    group   => $group,
#    require => Utils::Zip::Unzip_file[$dlfile]
#  }



}
