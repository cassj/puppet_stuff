class git::gitlab::users($pubkey,$privkey){

  group {'git':
    ensure => present
  }
  user {'git':
    ensure  => present,
    shell   => '/bin/sh',
    home    => '/home/git',
#    system  => true,
    gid     => 'git'
  } 
  file {'/home/git':
    ensure  => directory,
    owner   => 'git',
    group   => 'git',
    mode    => 750,
    require => User['git']
  }
  file{'/home/git/bin':
    ensure  => directory,
    owner   => 'git',
    group   => 'git',
    mode    => 755,
    require => User['git']
  }
  file{'/home/git/.ssh':
    ensure  => directory,
    owner   => 'git',
    group   => 'git',
    mode    => 700,
    require => File['/home/git']
  }
  file{'/home/git/.ssh/authorized_keys':
    ensure  => file,
    owner   => 'git',
    group   => 'git',
    mode    => 600,
    require => File['/home/git/.ssh']
  }
  user {'gitlab':
    ensure  => present,
    gid     => 'git',
    home    => '/home/gitlab',
    shell   => '/bin/bash'
  }
  file {'/home/gitlab':
    ensure  => directory,
    owner   => 'gitlab',
    group   => 'git',
    mode    => 755,
    require => User['gitlab']
    
  }
  file {"/home/gitlab/.ssh":
    ensure  => directory,
    mode    => 700,
    owner   => 'gitlab',
    group   => 'git',
    require => File["/home/gitlab"]
  }
  file {"/home/gitlab/.ssh/id_rsa":
    ensure  => file,
    mode    => 600,
    owner   => 'gitlab',
    group   => 'git',
    source  => $privkey,
    require => File["/home/gitlab/.ssh"]
  }
  file {'/home/gitlab/.ssh/id_rsa.pub':
    ensure  => file,
    mode    => 600,
    owner   => 'gitlab',
    group   => 'git',
    source  => $pubkey,
    require => File["/home/gitlab/.ssh"]
  }

}
