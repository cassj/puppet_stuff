class ruby191::install {
  
  # make sure you're not installing this over an existing ruby
  package{'ruby':
    ensure => absent
  }
  package{'rubygems':
    ensure => 'absent'
  }
  package {$ruby191::params::pkg_name:
    ensure => installed,
  }

  # NOTE: You need to have puppet 2.7+ otherwise it won't work
  # with ruby 1.9

#  # links assorted binaries - update-alternatives doesn't seem to work.
  exec{'link-ruby191':
    command => '/bin/ln -s /usr/bin/ruby1.9.1 /usr/bin/ruby',
    unless => '/usr/bin/test -L /usr/bin/ruby',
    subscribe => Package[$ruby191::params::pkg_name]
  }
  exec{'link-gem191':
    command => '/bin/ln -s /usr/bin/gem1.9.1 /usr/bin/gem',
    unless  => '/usr/bin/test -L /usr/bin/gem',
    subscribe => Package[$ruby191::params::pkg_name]
  }
  exec{'link-erb191':
    command => '/bin/ln -s /usr/bin/erb1.9.1 /usr/bin/erb',
    unless  => '/usr/bin/test -L /usr/bin/erb',
    subscribe => Package[$ruby191::params::pkg_name]
  }
  exec{'link-irb191':
    command => '/bin/ln -s /usr/bin/irb1.9.1 /usr/bin/irb',
    unless  => '/usr/bin/test -L /usr/bin/irb',
    subscribe => Package[$ruby191::params::pkg_name]
  }
  exec{'link-rake191':
    command => '/bin/ln -s /usr/bin/rake1.9.1 /usr/bin/rake',
    unless  => '/usr/bin/test -L /usr/bin/rake',
    subscribe => Package[$ruby191::params::pkg_name]
  }
  exec{'link-rdoc191':
    command => '/bin/ln -s /usr/bin/rdoc1.9.1 /usr/bin/rdoc',
    unless  => '/usr/bin/test -L /usr/bin/rdoc',
    subscribe => Package[$ruby191::params::pkg_name]
  }
  exec{'link-testrb191':
    command => '/bin/ln -s /usr/bin/testrb1.9.1 /usr/bin/testrb',
    unless  => '/usr/bin/test -L /usr/bin/testrb',
    subscribe => Package[$ruby191::params::pkg_name]
  }
  
}
