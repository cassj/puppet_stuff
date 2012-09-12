class puppet::config{
  
  include puppet::params


  file {"/etc/default/puppet":
    ensure => file,
    source => "puppet:///modules/puppet/etc-default-puppet",
    owner  => 'root',
    group  => 'root',
    mode   => 644
  }

  file { '/etc/puppet/puppet.conf':
    ensure => present,
    content => template('puppet/puppet.conf.erb'),
    owner => 'puppet',
    group => 'puppet',
    require => [Class['puppet::install'],File['/etc/default/puppet']],
    notify => Class['puppet::service']

  }
  

}
