class opal::install ($version){

  case $operatingsystem{
    /Ubuntu|Debian/:{

     file {'/root/obiba.org.key':
       ensure => file,
       owner  => 'root',
       group  => 'root',
       mode   => 700,
       source => 'puppet:///modules/opal/obiba.org.key'
     }

      exec {"opal-obiba-key":
        command => "/usr/bin/apt-key add /root/obiba.org.key", 
        refreshonly => true,
        subscribe => File['/root/obiba.org.key']
      }
     
      # Note to self - this is the whole obiba repo so if you try and install
      # two obiba components on one server it will complain. 
      file {"/etc/apt/sources.list.d/opal.list":
        ensure => file,
        owner  => 'root',
        group  => 'root',
        mode   => 644,
        source => 'puppet:///modules/opal/opal.list'
      }
      exec{'/usr/bin/apt-get update':
        refreshonly => true,
        subscribe => File['/etc/apt/sources.list.d/opal.list']
      }

      package { "opal":
       ensure   => $version,
       require  => File['/etc/apt/sources.list.d/opal.list']
      }
    }
    /(RedHat|CentOS|Fedora|Scientific)/:{
      fail("Opal is only available as a .deb package. Please install on a Debian-based system.")
    } 
  }

}
