class my_fw::pre {
  Firewall {
    require => undef,
  }

  # Default firewall rules
  firewall { '000 accept all icmp':
    proto   => 'icmp',
    action  => 'accept',
  }->
  firewall { '001 accept all to lo interface':
    proto   => 'all',
    iniface => 'lo',
    action  => 'accept',
  }->
  firewall { '002 accept related established rules':
    proto   => 'all',
    state   => ['RELATED', 'ESTABLISHED'],
    action  => 'accept',
  }->
  firewall { '100 allow ssh on 22':
      state => ['NEW'],
      dport => '22',
      proto => 'tcp',
      action  => 'accept',
  }->
  firewall {'101 forward 51515 to ssh on 22':
    chain    => 'PREROUTING',
    table    => 'nat',
    proto    => 'tcp',
    jump     => 'REDIRECT',
    dport    => '51515',
    toports   => '22'
  }

}

