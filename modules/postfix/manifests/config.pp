class postfix::config{
 
  File {
    owner => $postfix::params::user,
    group => $postfix::params::user,
    mode  => 0644
  }

  file{$postfix::params::cfg_master:
    ensure  => present,
    source  => "puppet:///modules/postfix/master.cf",
    require => Class['postfix::install'],
    notify  => Class['postfix::service']
  }

  file{$postfix::params::cfg_main:
    ensure   => present,
    content  => template("postfix/main.cf.erb"),
    require  => Class['postfix::install'],
    notify   => Class['postfix::service']
  }	
}
