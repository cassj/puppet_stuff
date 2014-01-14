class postfix::config($master_file,$main_template,$sasl_passwd_file){
 
  File {
    owner => $postfix::params::user,
    group => $postfix::params::user,
    mode  => 0644
  }

  file{$postfix::params::cfg_master:
    ensure  => present,
    owner   => 'root',
    source  => $master_file,
    require => Class['postfix::install'],
    notify  => Class['postfix::service']
  }

  file{$postfix::params::cfg_main:
    ensure   => present,
    owner    => 'root',
    content  => template($main_template),
    require  => Class['postfix::install'],
    notify   => Class['postfix::service']
  }	

  if($sasl_passwd_file != ""){
  file{"/etc/postfix/sasl_passwd":
    ensure   => present,
    source   => $sasl_passwd_file,
    owner    => 'root',
    mode     => 600,
    require  => File[$postfix::params::cfg_main],
    notify   => Exec['sasl_db']
  }

  exec{"sasl_db":
    cwd     => "/etc/postfix",
    command => "/usr/sbin/postmap sasl_passwd",
    require => File["/etc/postfix/sasl_passwd"],
    notify  => File['/etc/postfix/sasl_passwd.db']
  }

  file{"/etc/postfix/sasl_passwd.db":
    ensure => present,
    mode   => 600,
    owner   => 'root',
    group  => 'postfix',
    notify => Class['postfix::service']
  }
  }
}
