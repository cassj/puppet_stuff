class git::gitlab($pubkey, $privkey, $config, $dbconfig, $unicornconfig){
  require 'python::pip'

  class {'git::gitlab::users':
           pubkey  => $pubkey, 
           privkey => $privkey
  }
 include git::gitlab::gitolite

 class{'git::gitlab::gitlab':
    config        => $config,
    dbconfig      => $dbconfig,
    unicornconfig => $unicornconfig
 }
 include gitlab::service
 
}
