class opal::install {

  case $operatingsystem{
    /Ubuntu|Debian/:{

      # They have a repository now, do:
      # wget -q -O - http://pkg.obiba.org/obiba.org.key | sudo apt-key add -
      # and in /etc/apt/sources.list: deb http://pkg.obiba.org stable/
     

      file{"/opt/debs":
        ensure => directory
      }

      file{"/opt/debs/opal.deb":
        ensure => present,
        owner  => root,
        group  => root,
        mode   => 644,
        source => "puppet:///modules/opal/opal.deb"
      }
  
      package { "opal":
       provider => dpkg,
       ensure   => latest,
       source   => "/opt/debs/opal..deb"
      }
    }
    /(RedHat|CentOS|Fedora|Scientific)/:{
      fail("Opal is only available as a .deb package. Please install on a Debian-based system.")
    } 
  }

}
