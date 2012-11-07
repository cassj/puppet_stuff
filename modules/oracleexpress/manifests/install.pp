class oracleexpress::install {

  # upload rpm file
  file {'/root/oracle-xe-11.2.0-1.0.x86_64.rpm':
    ensure => file,
    owner  => 'root',
    group  => 'root',
    mode   => 700,
    source => 'puppet:///modules/oracleexpress/oracle-xe-11.2.0-1.0.x86_64.rpm'
  }
  
  # install the rpm file 
  package {'oracle-xe':
    ensure   => installed,
    provider => 'rpm', 
    source   => 'file:///root/oracle-xe-11.2.0-1.0.x86_64.rpm',
    require  => File['/root/oracle-xe-11.2.0-1.0.x86_64.rpm']
  }
  
  # set the appropriate kernel params

  # and 
  exec { 'load-sysctl':
    command => "/sbin/sysctl -p /etc/sysctl.conf",
    refreshonly => true
  }

}
