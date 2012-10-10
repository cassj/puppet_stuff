class epel{
 
  file{'/tmp/epel.noarch.rpm':
    ensure => file,
    owner  => 'root',
    group  => 'root',
    mode   => '755',
    source => 'puppet:///modules/epel/epel.noarch.rpm'
  }
  exec{'install-epel':
    command  => '/bin/rpm -i /tmp/epel.noarch.rpm',
    unless   => '/bin/rpm -qa | /bin/grep epel',
    require  => File['/tmp/epel.noarch.rpm'],
    subscribe => File['/tmp/epel.noarch.rpm']
  }
}
