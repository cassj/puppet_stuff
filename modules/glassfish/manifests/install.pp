class glassfish::install{

  include glassfish::params
 
  Exec{ path => $glassfish::params::path }

  file {"$glassfish::params::install_dir":
    ensure => directory
  }

  # fetch the install file
  utils::download_file {"$glassfish::params::download_file":
    file      => $glassfish::params::download_file,
    site      => "$glassfish::params::download_site",
    cwd       => "$glassfish::params::install_dir",
    creates   => "$glassfish::params::install_dir/$glassfish::params::download_file",
    require   => File["$glassfish::params::install_dir"],
    user      => 'root',
    group     => 'root',
    mode      => 700
  }


  # upload the install answers.
  file{"$glassfish::params::install_dir/answers":
     content   => template('glassfish/answers.erb'),
     owner   => 'root',
     group   => 'root',
     mode    => 600,
     require => File["$glassfish::params::install_dir"]
  }


  # Run the installer
  exec{'glassfish-install':
    command => "$glassfish::params::install_dir/glassfish-3.1.2.2-unix.sh -a answers -s",
    creates => "$glassfish::params::install_dir/glassfish"
  }


}
