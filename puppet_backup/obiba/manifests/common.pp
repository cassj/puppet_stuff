class obiba::common ($user, $home, $group) {


  group {$group:
    ensure => present
  }

  user {'obiba':
    ensure => present,
    gid    => $group,
    home   => $home,
    comment => 'Obiba user',
    shell   => '/sbin/nologin',
    require => Group[$group]
  }

  file {'/opt/obiba':
    ensure => directory,
    owner  => $user,
    group  => $group,
    mode   =>  755,
    require => User[$user]
  }


}
