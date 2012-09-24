class opal::firewall {

  require 'my_fw' 

  firewall {'110 allow ssh on 8022':
    state => 'NEW',
    dport => '8022',
    proto => 'tcp',
    action  => 'accept'
  }   

  firewall {'111 forward 51516 to ssh on 8022':
    chain    => 'PREROUTING',
    table    => 'nat',
    proto    => 'tcp',
    dport    => '51516',
    jump     => 'REDIRECT',
    toports  => '8022'
  }

  # not forwarding these, just ssh -D PORT to the box and set your browser proxy.
  firewall {'112 allow http on 8080':
    state => 'NEW',
    action  => 'accept',
    proto => 'tcp',
    dport => '8080'      
  }
  firewall {'113 allow https on 8443':
    state  => 'NEW',
    action   => 'accept',
    proto  => 'tcp',
    dport  => '8443'
  }


}
