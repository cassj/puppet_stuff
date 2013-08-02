define users::key( $user, $keyname=$name, $key, $keytype='ssh-rsa', $home="/home/$user" ){

  ssh_authorized_key{$keyname:
    ensure  => present,
    key     => $key, 
    type    => $keytype,
    user    => $user,
    require => Users::User[$user]
  }

}
