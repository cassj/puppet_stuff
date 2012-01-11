class dataverse::install {

  include dataverse::params

  Exec{path => $dataverse::params::path}

  group {$dataverse::params::group:
    ensure => present,
  }

  user {$dataverse::params::user:
    ensure     => present,
    shell      => '/sbin/nologin',
    gid        => $dataverse::params::group,
    home       => $dataverse::params::libdir,
    managehome => true,
    require    => Group[$dataverse::params::group],
  }

  file{$dataverse::params::libdir:
    ensure  => directory,
    owner   => $dataverse::params::user,
    group   => $dataverse::params::group,
    mode    => 755,
    require => [User[$dataverse::params::user], Group[$dataverse::params::group]]
  }

  file{"$dataverse::params::libdir/$dataverse::params::install_file":
    ensure  => present,
    owner   => $dataverse::params::user,
    group   => $dataverse::params::group,
    source  => "puppet:///modules/dataverse/$dataverse::params::install_file",
    require => [File[$dataverse::params::libdir], User[$dataverse::params::user], Group[$dataverse::params::group]]
  }

  utils::zip::unzip_file{"$dataverse::params::libdir/$dataverse::params::install_file":
    cwd      => $dataverse::params::libdir,
    user     => $dataverse::params::user,
    group    => $dataverse::params::group,
    creates  => "$dataverse::params::libdir/$dataverse::params::install_dir",
    require  => File["$dataverse::params::libdir/$dataverse::params::install_file"]
  }

  file{"$dataverse::params::libdir/$dataverse::params::install_dir/dvninstall/answers.txt":
    source  => "puppet:///modules/dataverse/answers.txt",
    require => Utils::Zip::Unzip_file["$dataverse::params::libdir/$dataverse::params::install_file"]
  }

  # I think all this R and Rserve stuff should be in its own module, but it can live here for now.
  exec{'dataverse-install-rmodules':
    unless  => "echo 'library(Rserve);q()' | R --vanilla ",
    cwd     => "$dataverse::params::libdir/$dataverse::params::install_dir/dvnextra",
    command => '$dataverse::params::libdir/$dataverse::params::install_dir/dvnextra/installModules.sh'
  }

   service { 'rserve':
    ensure     => running,
    enable     => true,
    require    => Exec['dataverse-install-rmodules']
  }
 

  # This will fail if you try and run it twice. If you need to rerun, drop the db and user:
  # /usr/local/glassfish/bin/asadmin stop-domain
  # dropdb -U dvnApp dvnDb
  # dropuser -U dvnApp
  exec{'dataverse-install-script':
     unless  => "echo '\q' | psql -U dvnApp -d dvnDb",
     cwd     => "$dataverse::params::libdir/$dataverse::params::install_dir/dvninstall",
     command => "$dataverse::params::libdir/$dataverse::params::install_dir/dvninstall/install < answers.txt"
  }

  #open port 80
  

}
