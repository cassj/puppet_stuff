define mediawiki::wiki(
  mysql_root_pass,
  db,
  db_user,
  db_pass,
  fqdn,
  $port=80,
  $docroot,
  $priority=10,
  $localsettings=''
){

  include apache,mysql,php
  include mediawiki::params
  include utils::tar

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

  # create apache vhost
  apache::vhost{$fqdn:
    port     => $port,
    docroot  => $docroot,
    priority => $priority
  }



  # ensure your docroot location exists and is owned by apache
  # currently this isn't bothering to deal with selinux. 
  # as long as your files are under /var/www somewhere,
  # they'll inherit the right context
  file{$docroot:
    ensure => directory,
    owner  => $apache::params::user,
    group  => $apache::params::group,
  }
 
  # fetch the install tarball
  utils::download_file {"$fqdn-$mediawiki::params::download_file":
    file      => $mediawiki::params::download_file,
    site      => "$mediawiki::params::download_site",
    cwd       => "$docroot",
    creates   => "$docroot/$name",
    require   => File["$docroot"],
    user      => $apache::params::user,
    group     => $apache::params::group,
  }

  utils::tar::untar_file{"$fqdn-$mediawiki::params::download_file":
    file        => $mediawiki::params::download_file,
    cwd         => $docroot,
    user        => $apache::params::user,
    group       => $apache::params::group,
    gzip_filter => true,
    creates     => "$docroot/$mediawiki::params::download_dir",
    require     => Utils::Download_file["$fqdn-$mediawiki::params::download_file"]
  }

  #create a symlink called 'wiki' to the unpacked dir
  exec{"mediawiki-symlink-$fqdn":
    command   => "/bin/ln -s $mediawiki::params::download_dir wiki",
    creates   => "$docroot/wiki",
    cwd       => $docroot,
    require   => Utils::Tar::Untar_file["$fqdn-$mediawiki::params::download_file"], 
    subscribe => Utils::Tar::Untar_file["$fqdn-$mediawiki::params::download_file"] 
  }

  # Upload a LocalSettings file if one is specified. Note that this will 
  # fail if you haven't got a working database already.
  # If you're creaating a brand new wiki, you'll need to generate this
  # file by going to $fqdn/wiki to run the install script.
  if($localsettings){
    file{"$docroot/$mediawiki::params::download_dir/LocalSettings.php":
      ensure    => file,
      source    => $localsettings,
      owner     => $apache::params::user,
      group     => $apache::params::group,
      mode      => '755',
      require   => Utils::Tar::Untar_file["$fqdn-mediawiki::params::download_file"],
      subscribe => Utils::Tar::Untar_file["$fqdn-mediawiki::params::download_file"]
    }
  }

}

