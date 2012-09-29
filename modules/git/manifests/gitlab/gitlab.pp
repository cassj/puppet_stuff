class git::gitlab::gitlab(config,dbconfig,unicornconfig){

 require 'git::gitlab::gitolite'
 require 'ruby::params'
 require 'nginx'

  Exec{
    path  => ['/usr/local/sbin','/usr/local/bin','/usr/sbin','/usr/bin','/sbin','/bin','/home/git/bin',$ruby::params::gems_bin]
  }

 # Get gitlab stable branch 
  exec{'clone-gitlab-gitlab':
    command     => 'git clone -b stable https://github.com/gitlabhq/gitlabhq.git gitlab',
    cwd         => '/home/gitlab',
    user        => 'gitlab',
    environment => 'HOME=/home/gitlab',
    creates     => '/home/gitlab/gitlab'
  }

  # config files
  file{'/home/gitlab/gitlab/config/gitlab.yml':
    ensure  => file,
    owner   => 'gitlab',
    group   => 'git',
    mode    => 660,
    source  => $config,
    require => Exec['clone-gitlab-gitlab']
  }

  file{'/home/gitlab/gitlab/config/database.yml':
    ensure  => file,
    owner   => 'gitlab',
    group   => 'git',
    mode    => 660,
    source  => $dbconfig,
    require => Exec['clone-gitlab-gitlab']
  }
    
  #Install gems 
  # this seems to be failing unless you run it manually and I can't see why.
  exec {'gitlab-install-gems':
    command     => 'bundle install --without development test --deployment',
    user        => 'gitlab',
    cwd         => '/home/gitlab/gitlab',
    environment => 'HOME=/home/gitlab',
    refreshonly => true,
    subscribe   => File['/home/gitlab/gitlab/config/gitlab.yml']
  }

  #Setup database
  exec{'gitlab-setup-database':
    command     => 'bundle exec rake gitlab:app:setup RAILS_ENV=production',
    user        => 'gitlab',
    cwd         => '/home/gitlab/gitlab',
    environment => 'HOME=/home/gitlab',
    subscribe   => File['/home/gitlab/gitlab/config/database.yml'],
    refreshonly => true
  }

  #Setup GitLab hooks
  exec{'gitlab-setup-hooks':
    command     => 'cp /home/gitlab/gitlab/lib/hooks/post-receive /home/git/.gitolite/hooks/common/post-receive',
    user        => 'root',
    require     => Exec['setup_gitlab_gitolite'],
    refreshonly => true,
    subscribe   => Exec['setup_gitlab_gitolite'] # from git::gitlab::gitolite
  }
  file{'/home/git/.gitolite/hooks/common/post-receive':
    ensure      => file,
    owner       => 'git',
    group       => 'git',
    mode        => 660,
    require     => Exec['gitlab-setup-hooks'],
  }

  # Install init script
  file{'/etc/init.d/gitlab':
    ensure   => file,
    owner    => 'root',
    group    => 'root',
    mode     => 755,
    source   => 'puppet:///modules/git/gitlab.init',
    notify   => Class['git::gitlab::service']
  }

  # Unicorn
  file{'/home/gitlab/gitlab/config/unicorn.rb':
    ensure  => file,
    owner   => 'gitlab',
    group   => 'git',
    mode    => 660,
    source  => $unicornconfig,
    require => Exec['clone-gitlab-gitlab']
  }
  # this doesn't work unless you do it by hand. 
  exec{'gitlab-bundle-unicorn':
    command     => 'bundle exec unicorn_rails -c config/unicorn.rb -E production -D',
    user        => 'gitlab',
    cwd         => '/home/gitlab/gitlab',
    environment => 'HOME=/home/gitlab',
    subscribe   => File['/home/gitlab/gitlab/config/unicorn.rb'],
    refreshonly => true
  }

  # add the gitlab config to nginx
  file{'/etc/nginx/sites-available/gitlab':
    ensure   => file,
    owner    => 'root',
    group    => 'root',
    mode     => 755,
    source   => 'puppet:///modules/git/gitlab.nginx',
    require  => Package['nginx']
  }
  exec{'gitlab-ln-nginx':
    command   => 'ln -s /etc/nginx/sites-available/gitlab /etc/nginx/sites-enabled/gitlab',
    user      => 'root',
    creates   => '/etc/nginx/sites-enabled/gitlab',
    require   => File['/etc/nginx/sites-available/gitlab'],
    notify    => Class['nginx::service']
  }

 

} 
