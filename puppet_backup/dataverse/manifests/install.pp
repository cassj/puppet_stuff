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

  # Now log onto the remote machine, cd into the install_dir and run ./install
  # this is an interactive perl script, so just do it manually.
  # apparently can't be used to upgrade an existing version.


}
