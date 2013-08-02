class git::gitlab::gitlab ($gitlab_config_file, $gitlab_unicorn_config_file,$gitlab_git_config_file, $gitlab_database_config_file,$gitlab_init_file, $gitlab_puma_config_file, $gitlab_nginx_config_file){

  # Note that this requires teh vcsrepo module on the server
  # puppet module install puppetlabs/vcsrepo

  # clone the appropriate version of gitlab git repo: 
  vcsrepo { "/home/git/gitlab":
      ensure => present,
      provider => git,
      source => "https://github.com/gitlabhq/gitlabhq.git",
      revision => '5-3-stable'
  }

  file {"/home/git/gitlab/config/gitlab.yml":
    ensure  => file,
    owner   => 'git',
    group   => 'git',
    mode    => 755,
    source  => $gitlab_config_file,
    require => Vcsrepo['/home/git/gitlab']
  }

  # ensure write perms on log and tmp dirs
  file {'/home/git/gitlab/log':
    ensure  => directory,
    owner   => 'git',
    group   => 'git',
    mode    => '755',
    require =>  Vcsrepo['/home/git/gitlab']
  }
  file {'/home/git/gitlab/tmp':
    ensure  => directory,
    owner   => 'git',
    group   => 'git',
    mode    => '755',
    require =>  Vcsrepo['/home/git/gitlab']
  }

  # create a directory for satellites
  file {'/home/git/gitlab-satellites':
    ensure => directory,
    owner  => 'git',
    group  => 'git',
    mode   => '755',
    require => User['git']
  }
  # for sockets
  file {'/home/git/gitlab/tmp/sockets':
    ensure => directory,
    owner  => 'git',
    group  => 'git',
    mode   => '755',
    require =>  Vcsrepo['/home/git/gitlab']
  }
  # and for pids
  file {'/home/git/gitlab/tmp/pids':
    ensure => directory,
    owner  => 'git',
    group  => 'git',
    mode   => '755',
    require =>  Vcsrepo['/home/git/gitlab']
  }
  # and for uploads (or backups will fail)
  file {'/home/git/gitlab/public/uploads':
    ensure => directory,
    owner  => 'git',
    group  => 'git',
    mode   => '755',
    require =>  Vcsrepo['/home/git/gitlab']
  }

  # unicorn config  
  file {"/home/git/gitlab/config/unicorn.rb":
    ensure => file,
    owner  => 'git',
    group  => 'git',
    mode   => 755,
    source  => $gitlab_unicorn_config_file,
    require =>  Vcsrepo['/home/git/gitlab']
  }


  # git config
  file {'/home/git/.gitconfig':
    ensure => file,
    owner  => 'git',
    group  => 'git',
    mode   => 755,
    source  => $gitlab_git_config_file,
    require => User['git']
  }
  
  # puma config
  file {'/home/git/gitlab/config/puma.rb':
    ensure => file,
    owner  => 'git',
    group  => 'git',
    mode   => 750,
    source => $gitlab_puma_config_file,
    require =>  Vcsrepo['/home/git/gitlab']
  }


  # datbase settings
  file {'/home/git/gitlab/config/database.yml':
    ensure => file,
    owner  => 'git',
    group  => 'git',
    mode   => 600,
    source  => $gitlab_database_config_file,
    require => [Class['git::gitlab::database'], Vcsrepo['/home/git/gitlab']]
  }

  # nginx config
  file {'/etc/nginx/sites-available/gitlab':
    ensure  => file,
    owner   => 'root',
    group   => 'root',
    mode    => 755,
    source  => $gitlab_nginx_config_file,
    require => Class['nginx']
  }
  exec{'/bin/ln -s /etc/nginx/sites-available/gitlab /etc/nginx/sites-enabled/gitlab':
    require => File['/etc/nginx/sites-available/gitlab'],
    creates => '/etc/nginx/sites-enabled/gitlab',
    notify  => Service[$nginx::params::service] 
  }


  # run the install script
  exec {'/usr/local/bin/bundle install --deployment --without development test postgres unicorn aws':
    cwd => '/home/git/gitlab',
    user => 'git',
    require => User['git'],
    subscribe => Vcsrepo['/home/git/gitlab'],
    refreshonly => true
  } 

 file {'/home/git/gitlab/gitlab-install-yes':
    ensure => file,
    owner  => 'git',
    group  => 'git',
    mode   => '600',
    content => "yes\n",
    require => [User['git'],Vcsrepo['/home/git/gitlab']]
  }
 # Initialise the database and activate advanced features
 # Note that this will overwrite anything in the database, so we really need to make sure it's not being run
 # more than once. 
 exec {'/usr/local/bin/bundle exec rake gitlab:setup RAILS_ENV=production < /home/git/gitlab/gitlab-install-yes':
    cwd => '/home/git/gitlab',
    user => 'git',
    subscribe => File['/home/git/gitlab/gitlab-install-yes'],
    refreshonly => true 
 }

 # init script
 file {'/etc/init.d/gitlab':
   ensure => file,
   owner  => 'root',
   group  => 'root',
   mode   => 755,
   source => $gitlab_init_file,
   require => Vcsrepo['/home/git/gitlab']
 }

  # expects python2 binary. 
  exec{'/bin/ln -s /usr/bin/python /usr/bin/python2':
    creates => '/usr/bin/python2'
  }


}

