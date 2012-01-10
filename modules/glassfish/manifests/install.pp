class glassfish::install{

  include glassfish::params
 
  Exec{ path => $glassfish::params::path }

  file {"$glassfish::params::install_dir":
    ensure => directory
  }

  # fetch the install file
  utils::download_file {"$glassfish::params::download_file":
    file      => $glassfish::params::download_file,
    site      => "$glassfish::params::download_site",
    cwd       => "$glassfish::params::install_dir",
    creates   => "$glassfish::params::install_dir/$glassfish::params::download_file",
    require   => File["$glassfish::params::install_dir"],
    user      => 'root',
    group     => 'root',
    mode      => 700
  }

#  #and unzip it
#  utils::zip::unzip_file {$glassfish::params::download_file:
#    cwd      => "$glassfish::params::install_dir",
#    creates  => "$glassfish::params::install_dir/glassfish",
#    user     => 'root',
#    group    => 'root',
#    require  => Utils::Download_file[$glassfish::params::download_file]
#  }
# 
#
## for now, I only need the temp domain. Will write something to manage
## domains and config when I need it.
#exec{'glassfish-start-domain':
#  command => "$glassfish::params::as_install/bin/asadmin start-domain",
#  unless  => "$glassfish::params::as_install/bin/asadmin list-domains | grep 'domain1 running'" 
#}


  file{"$glassfish::params::install_dir/accept.txt":
    content => "A\n",
  }
  exec {'glassfish-jar-install':
    cwd     => $glassfish::params::install_dir,
    command => "java -Xmx256m -jar $glassfish::params::install_dir/$glassfish::params::download_file < $glassfish::params::install_dir/accept.txt",
    creates => "$glassfish::params::install_dir/glassfish",
    require => [ File["$glassfish::params::install_dir/$glassfish::params::download_file"], File["$glassfish::params::install_dir/accept.txt"] ]
  }
  exec {'glassfish-setx':
    cwd     => "$glassfish::params::as_install",
    command => "chmod -R +x lib/ant/bin",
    require => Exec['glassfish-jar-install']
  }
  exec{'sunjava-glassfish-setupscript':
    cwd     => "$glassfish::params::as_install",
    command => "$glassfish::params::as_install/lib/ant/bin/ant -f setup.xml",
    creates => "$glassfish::params::as_install/domains/domain1",
    require => Exec['glassfish-setx']
  }

#  #to get this to work with ant we need to set some environment variables
#  file{'/etc/profile.d/glassfish.sh':
#    ensure => file,
#    owner  => 'root',
#    group  => 'root',
#    source => 'puppet:///modules/glassfish/glassfish.sh' 
#  }

  
}
