class puppet::firewall {

  require 'my_fw' 

  firewall {'110 puppet on 8140':
    state => 'NEW',
    dport => '8140',
    proto => 'tcp',
    action  => 'accept'
  }   

}
