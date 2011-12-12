class ldap::server::config {
  
  include ldap::server::params
  include ftp::server::params 

  Exec{path => $ldap::server::params::path }

  # bdb file
  file {$ldap::server::params::bdb_ldif_file:
    ensure  => present,
    owner   => $ldap::server::params::user,
    group   => $ldap::server::params::group,
    mode    => 0600,
    content => template('ldap/server/olcDatabase={1}bdb.ldif.erb'),
    require => Class['ldap::server::install'],
    notify  => Class['ldap::server::service'],
  }

  # monitor file
  file {$ldap::server::params::monitor_ldif_file:
    ensure  => present,
    owner   => $ldap::server::params::user,
    group   => $ldap::server::params::group,
    mode    => 0600,
    content => template('ldap/server/olcDatabase={2}monitor.ldif.erb'),
    require => Class['ldap::server::install'],
    notify  => Class['ldap::server::service'],
  }


  file {$ldap::server::params::ldap_dir:
    ensure  => directory,
    owner   => $ldap::server::params::user,
    group   => $ldap::server::params::group,
    mode    => 0600,
    require => Class['ldap::server::install']
  }


  # new config file - just switches on tls
  file {$ldap::server::params::sysconfig_file:
    ensure  => present,
    owner   => $ldap::server::params::user,
    group   => $ldap::server::params::group,
    mode    => 0600,
    source  => 'puppet:///modules/ldap/server/sysconfig-ldap',
    require => Class['ldap::server::install']
  }


  # keys should probably be a definition in the ssl module, but I haven't got 
  # time to think it through right now
  exec{"ldap-server-ssl-keys":
    unless  => "test -s $ldap::server::params::ssl_out",
    command => "openssl req -batch -new -x509 -nodes -out $ldap::server::params::ssl_out -keyout $ldap::server::params::ssl_keyout -days $ldap::server::params::ssl_days",
    require => Class['ssl::install']
  }

  # and we need to copy the key to the ftp directory so clients can pick it up.
  exec {'ldap-key2ftp':
    command => "cp $ldap::server::params::ssl_keyout $ldap::server::params::key_ftp",
    require => Exec['ldap-server-ssl-keys'],
  }

}


