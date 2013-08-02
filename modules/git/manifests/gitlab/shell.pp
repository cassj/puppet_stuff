class git::gitlab::shell ($config_file){

  # Note that this requires teh vcsrepo module on the server
  # puppet module install puppetlabs/vcsrepo

  # clone the appropriate version of gitlab-shell git repo: 
  vcsrepo { "/home/git/gitlab-shell":
      ensure   => present,
      provider => git,
      source   => "https://github.com/gitlabhq/gitlab-shell.git",
      revision => 'v1.4.0'
  }

  file {"/home/git/gitlab-shell/config.yml":
    ensure  => file,
    owner   => 'git',
    group   => 'git',
    mode    => 755,
    source  => $config_file,
    require => Vcsrepo["/home/git/gitlab-shell"]
  }

  exec{"/home/git/gitlab-shell/bin/install":
   cwd => '/home/git/gitlab-shell',
   user => 'git',
   creates => '/home/git/.ssh/authorized_keys',
   require => File['/home/git/gitlab-shell/config.yml']
   
  } 


}

