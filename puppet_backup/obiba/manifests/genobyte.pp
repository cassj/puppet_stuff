class obiba::genobyte(  
  $obiba_user,
  $obiba_group,
  $obiba_home
) {

  include obiba::params
  include utils

  Exec { path => $obiba::params::path }
  
  file{"$obiba_home/genobyte":
    ensure => directory,
    owner  => 'root',
    group  => 'root'
  }

  file{"$obiba_home/genobyte/download":
    ensure => directory,
    owner  => 'root',
    group  => 'root'
  }

  $site   = "http://maven.obiba.org/maven2/org/obiba/genobyte/"
  $dlfile = "genobyte-1.4.3-bin.tar.gz"
  utils::download_file {$dlfile:
    site      => $site,
    cwd       => "$obiba_home/genobyte/download",
    creates   => "$obiba_home/genobyte/download/$name",
    require   => File["$obiba_home/genobyte/download"],
    user      => 'root',
    group     => 'root',
  }

  exec{'genobyte-untar':
    command  => "tar -xvzf $obiba_home/genobyte/download/$dlfile",
    cwd       => "$obiba_home/genobyte",
    user      => 'root',
    group     => 'root',
    require   => Utils::Download_file[$dlfile]

  }


}
