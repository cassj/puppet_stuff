define wordpress::blog(
  mysql_root_pass,
  db,
  db_user,
  db_pass,
  fqdn,
  $port=80,
  $docroot,
  $priority=10,
  $localsettings='',
  $rooturl = false,
  $create_vhost = true,
  $create_docroot = false,
  $blog_dir = 'blog'
){

  include apache,mysql,php
  include wordpress::params
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

if ($create_vhost){
  apache::vhost{$fqdn:
     port     => $port,
     docroot  => $docroot,
     priority => $priority
   }
}


  # ensure your docroot location exists and is owned by apache
  # currently this isn't bothering to deal with selinux. 
  # as long as your files are under /var/www somewhere,
  # they'll inherit the right context
  if ($create_docroot){
    file{"$docroot":
      name   => $docroot,
      ensure => directory,
      owner  => $apache::params::user,
      group  => $apache::params::group,
    }
  }
 

  # fetch the install tarball
  utils::download_file {"$fqdn-$wordpress::params::download_file":
    file      => $wordpress::params::download_file,
    site      => "$wordpress::params::download_site",
    cwd       => "$docroot",
    creates   => "$docroot/$name",
    require   => File["$docroot"],
    user      => $apache::params::user,
    group     => $apache::params::group,
  }


  utils::tar::untar_file{"$fqdn-$wordpress::params::download_file":
    file        => $wordpress::params::download_file,
    cwd         => $docroot,
    user        => $apache::params::user,
    group       => $apache::params::group,
    gzip_filter => true,
    creates     => "$docroot/$wordpress::params::download_dir",
    require     => Utils::Download_file["$fqdn-$wordpress::params::download_file"]
  }

  if ($rooturl) {
    # copy the files into the root dir
    exec{"wordpress-move-$fqdn":
      command  => "/bin/mv  $wordpress::params::download_dir/* $docroot/",
      cwd      => $docroot,
      creates  => "$docroot/wp-admin",
      require   => Utils::Tar::Untar_file["$fqdn-$wordpress::params::download_file"], 
      subscribe => Utils::Tar::Untar_file["$fqdn-$wordpress::params::download_file"] 
    } 
  } 
  else{
    # create a symlink called 'blog' to the unpacked dir
    exec{"wordpress-symlink-$fqdn":
      command   => "/bin/ln -s $wordpress::params::download_dir $blog_dir",
      creates   => "$docroot/$blog_dir",
      cwd       => $docroot,
      require   => Utils::Tar::Untar_file["$fqdn-$wordpress::params::download_file"], 
      subscribe => Utils::Tar::Untar_file["$fqdn-$wordpress::params::download_file"] 
    }
  }

# At this point, go to $fqdn[/$blog]/wp-admin/install.php


}

