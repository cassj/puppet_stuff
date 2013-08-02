class openvas::install{

  include openvas::params


  # Download the installer from atomic
  utils::download_file {"$openvas::params::download_file":
    file      => $openvas::params::download_file,
    site      => "$openvas::params::download_site",
    cwd       => "/tmp",
    creates   => "/tmp/$openvas::params::download_file",
    user      => 'root',
    group     => 'root',
    mode      => 700
  }

  file{"/tmp/openvas_install_answers":
    content => "yes\n",
    owner   => "root",
    group   => "root",
    mode    => "600"
  }

  # This doesn't work, have to do it manually 
  # should really get the source and make a proper RPM
#  exec{"install_openvas_repo":
#    command      => "/tmp/$openvas::params::download_file < /tmp/openvas_install_answers",
#    require      => [Utils::Download_file["$openvas::params::download_file"], File["/tmp/openvas_install_answers"]],
#    subscribe    => Utils::Download_file["$openvas::params::download_file"],
#    refreshonly => true
#  }

  package{$openvas::params::pkg:
    ensure  => present,
    require => Utils::Download_file[$openvas::params::download_file],
  }
 
# now manually run openvas-setup 

}
