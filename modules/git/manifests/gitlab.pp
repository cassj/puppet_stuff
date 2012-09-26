class git::gitlab(pubkey, privkey){
  class {'git::gitlab::users':
           pubkey  => $pubkey, 
           privkey => $privkey
  }
 include git::gitlab::gitolite
}
