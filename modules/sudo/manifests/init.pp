# parameterized on the grounds that I don't want my sudoers file 
# in a public module 
class sudo ($sudoers_file){

  package {sudo:
    ensure => present,
  }

  if $operatingsystem == "Ubuntu" {
    package {"sudo-ldap":
      ensure  => present,
      require => Package['sudo'],
    }
  }

  file { '/etc/sudoers':
    owner   => 'root',
    group   => 'root',
    mode    => 0440,
    source  => $sudoers_file,
    require => Package['sudo'],
  }

}
