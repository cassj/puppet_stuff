class opal::install {

  case $operatingsystem{
    /Ubuntu|Debian/:{

      exec {"opal-obiba-key":
        command => "/usr/bin/wget http://pkg.obiba.org/obiba.org.key && apt-key add obiba.org.key ", 
        unless  => "/bin/grep 'obiba' /etc/apt/sources.list"
      }
      exec{"opal-obiba-repo":
         command => '/bin/echo "\ndeb http://pkg.obiba.org stable/ \n" /etc/apt/sources.list',
         unless  => "/bin/grep 'obiba' /etc/apt/sources.list "
      }

      package { "opal":
       ensure   => latest,
      }
    }
    /(RedHat|CentOS|Fedora|Scientific)/:{
      fail("Opal is only available as a .deb package. Please install on a Debian-based system.")
    } 
  }

}
