class obiba::mica 
(
  $obiba_fqdn,
  $obiba_user, 
  $obiba_group, 
  $obiba_home, 
  $mysql_root_pass = "",
  $db,
  $db_user,
  $db_pass,
  $port
) {

  include obiba::params
  include apache::params

  Class['php']->Class['obiba::mica']
  Class['mysql']->Class['obiba::mica']
  #Class['apache']->Class['obiba::mica']

  $dlfile    = $obiba::params::mica_dlfile
  $site      = $obiba::params::mica_site  
  $micadir   = $obiba::params::micadir
#  $opalhome  = "$obiba_home/opal/opal-server/$serverdir"

  #create a folder to put it in.
  file {"$obiba_home/mica":
    ensure  => directory,
    owner   => $obiba_user,
    group   => $obiba_group,
    mode    => 755,
    require => Class['obiba::common'],
  }

  file {"$obiba_home/mica/download":
    ensure  => directory,
    owner   => $user,
    group   => $group,
    mode    => 700,
    require => File["$home/mica"],
  }

  utils::download_file {$dlfile:   
    site      => $site,
    cwd       => "$obiba_home/mica/download",
    creates   => "$obiba_home/mica/download/$name",
    require   => File["$obiba_home/mica/download"],
    user      => $obiba_user,
    group     => $obiba_group,
  }

  utils::zip::unzip_file {$dlfile:
    cwd      => "$obiba_home/mica/download",
    creates  => "$mica_dir",
    user     => $apache::params::user,
    group    => $apache::params::group,
    require  => Utils::Download_file[$dlfile]
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
    require       => [Mysql::Database[$db], Mysql::User[$db_user]]
 }

  # and create apache vhost
  apache::vhost{$obiba_fqdn:
    port     => $port,
    docroot  => $micadir,
    priority => 10
  }



}
