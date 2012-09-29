class git::gitlab::gitolite{
  
  require 'git::gitlab::users'

  Exec{
    path  => ['/usr/local/sbin','/usr/local/bin','/usr/sbin','/usr/bin','/sbin','/bin']
  }

  # Clone GitLab's fork of the Gitolite source code:
  exec{'clone_gitlab_gitolite':
     command => 'git clone -b gl-v304 https://github.com/gitlabhq/gitolite.git /home/git/gitolite',
     cwd     => '/home/git',
     creates => '/home/git/gitolite',
     user    => 'git'
  }

  # Setup
  exec{'create_dotprofile':
    command  => 'echo -e "PATH=\$PATH:/home/git/bin\nexport PATH" >> /home/git/.profile',
    cwd      => '/home/git',
    creates  => '/home/git/.profile',
    user     => 'git' 
  }
 
  exec{'install_gitlab_gitolite':
    command  => '/home/git/gitolite/install -ln /home/git/bin',
    cwd      => '/home/git',
    user     => 'git',
    creates  => '/home/git/bin/gitolite'
  }

  exec{'copy_gitlab_keys':
    command  => 'cp /home/gitlab/.ssh/id_rsa.pub /home/git/gitlab.pub',
    user     => 'root',
    creates  => '/home/git/gitlab.pub'
  }
  file{'/home/git/gitlab.pub':
    ensure => file,
    owner  => 'git',
    group  => 'git',
    mode   => 0444,
    require => Exec['copy_gitlab_keys']
  }
  exec{'setup_gitlab_gitolite':
    command   => '/home/git/bin/gitolite setup -pk /home/git/gitlab.pub',
    user      => 'git', 
    cwd       => '/home/git',
    creates   => '/home/git/repositories',
    environment => 'HOME=/home/git',
    require   => File['/home/git/gitlab.pub']
  }  
  exec{'sed_gitlab_gitolite':
    command => "sed -i 's/0077/0007/g' /home/git/.gitolite.rc",
    user    => 'git',
    cwd     => '/home/git',
    refreshonly => true,
    require => Exec['setup_gitlab_gitolite']
  }


  # Permissions
 
  file {'/home/git/repositories':
    ensure => directory,
    owner  => 'git',
    group  => 'git',
    mode   => 770
  } 

  # add localhost rsa-key to known_hosts 
  sshkey{'git-localhost':
   ensure => present,
   key    => $sshrsakey,
   name   => 'localhost',
   type   => 'ssh-rsa'
  } 

}

