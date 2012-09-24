class git::firewall {

  require 'my_fw' 

  firewall {'110 allow git on 9418':
    state => 'NEW',
    dport => '9418',
    proto => 'tcp',
    action  => 'accept'
  }   

}
