class ruby191::dev {
  
  # make sure you're not installing this over an existing ruby
  package{'ruby-dev':
    ensure => absent
  }
  package {$ruby191::params::dev_pkg_name:
    ensure => installed,
  }


  
}
