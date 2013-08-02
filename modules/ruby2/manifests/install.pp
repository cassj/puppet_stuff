class ruby2::install {

  # should really turn this into a rpm / deb. but meh.

 file {'/opt/ruby2':
   ensure => 'directory',
   owner  => 'root',
   group  => 'root',
   mode   => 755
 }

  # Download ruby
  utils::download_file {"/opt/ruby2/$ruby2::params::ftp_file":
    file      => $ruby2::params::ftp_file,
    site      => "$ruby2::params::ftp_url",
    cwd       => "/opt/ruby2",
    creates   => "/opt/ruby2/$ruby2::params::ftp_file",
    user      => 'root',
    group     => 'root',
    mode      => 700,
    require   => File['/opt/ruby2']
  }

  # unpack
  utils::tar::untar_file{"/opt/ruby2/$ruby2::params::ftp_file":
    cwd       => '/opt/ruby2',
    user      => 'root',
    group     => 'root',
    creates   => "/opt/ruby2/$ruby2::params::unpacked_file",
    require   => Utils::Download_file["/opt/ruby2/$ruby2::params::ftp_file"],  
  }

  # configure
  exec{"/opt/ruby2/$ruby2::params::unpacked_file/configure":
    user => 'root',
    cwd => "/opt/ruby2/$ruby2::params::unpacked_file",
    creates => "/opt/ruby2/$ruby2::params::unpacked_file/Makefile",
    require => Utils::Tar::Untar_file["/opt/ruby2/$ruby2::params::ftp_file"]
  }
  # make
  exec{"ruby2-make":
    command => '/usr/bin/make',
    user => 'root',
    cwd => "/opt/ruby2/$ruby2::params::unpacked_file",
    timeout => 1800,
    subscribe   => Exec["/opt/ruby2/$ruby2::params::unpacked_file/configure"],
    refreshonly => true
  }
  # install
  exec{"ruby2-make-install":
    command => '/usr/bin/make install',
    user => 'root',
    cwd => "/opt/ruby2/$ruby2::params::unpacked_file",
    subscribe   => Exec["ruby2-make"],
    refreshonly => true
  }



}
