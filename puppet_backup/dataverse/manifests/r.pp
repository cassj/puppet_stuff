class dataverse::r{

  include r
  include utils::tar
  include dataverse::params

  Exec{path => $dataverse::params::path}

  $site = 'http://dvn-3.hmdc.harvard.edu/dist/R/'
  $file = 'dvnextra.tar'


  utils::download_file {$file:
    site      => $site,
    cwd       => "$dataverse::params::libdir",
    creates   => "/$dataverse::params::libdir/$file",
    user      => $dataverse::params::user,
    group     => $dataverse::params::group,
  }

  utils::tar::untar_file{$file:
    cwd       => $dataverse::params::libdir,
    user      => $dataverse::params::user,
    group     => $dataverse::params::group,
    creates   => "$dataverse::params::libdir/dvnextra",
    require   => Utils::Download_file[$file]

  }

  
  # This takes *ages* (like an hour or so)
  # but it installs a load of stuff. 
  # If 
  exec{"dataverse-r-modules":
    require => Utils::Tar::Untar_file[$file],
    command => "./installModules.sh",
    unless  => "Rscript -e 'library(Rserve)'",
    path    => "$dataverse::params::path:$dataverse::params::libdir/dvnextra/",
    cwd     => "$dataverse::params::libdir/dvnextra",
  }
  
}
