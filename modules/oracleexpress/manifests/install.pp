class oracleexpress::install {

  # upload rpm file
  file {'/root/oracle-xe-11.2.0-1.0.x86_64.rpm.zip':
    ensure => file,
    owner  => 'root',
    group  => 'root',
    mode   => 700,
    source => 'puppet:///modules/oracleexpress/oracle-xe-11.2.0-1.0.x86_64.rpm.zip'
  }

#  utils::zip::unzip_file{"/root/oracle-xe-11.2.0-1.0.x86_64.rpm.zip'":
#    cwd      => '/root',
#    user     => 'root',
#    group    => 'root',
#    creates  => "/root/Disk1'",
#    require  => File["/root/oracle-xe-11.2.0-1.0.x86_64.rpm.zip'"]
#  }


#  package {$ssh::params::pkg_name:
#    ensure => installed,
#  }
}
