define users::user( $user=$name, $home="/home/$name", $groups=undef, $comment="", $bash_profile="puppet:///modules/users/bash_profile", $bashrc="puppet:///modules/users/bashrc" ){

  # RHEL style group for each user. 
  # All users should use bash
  group{$user:
    ensure => present
  }
  user {$user:
    ensure     => present,
    shell      => '/bin/bash',
    gid        => $user,
    comment    => $comment,
    home       => $home,
    groups     => $groups,
    managehome => true,
    require    => Group[$user],
  }
  file { "$home":
    ensure  => directory,
    owner   => $user,
    group   => $user,
    mode    => 755,
    require => user[$user]
  }
  # we're using ssh keys for all users, so make sure
  # they have a directory to put them in.
  file { "$home/.ssh":
    ensure  => directory,
     owner   => $user,
     group   => $user,
     mode    => 700,
     require => File["$home"]
  }
  # bash config
  file{"$home/.bashrc":
    source  => $bashrc,
    owner   => $user,
    group   => $user,
    mode    => 600,
    require => File["$home"]
  }
  file{"$home/.bash_profile":
    source  => $bash_profile,
    owner   => $user,
    group   => $user,
    mode    => 600,
    require => File[$home]
  } 
  

}

