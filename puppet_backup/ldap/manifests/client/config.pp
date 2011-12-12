class ldap::client::config (){

  include ftp::client

  include ldap::client::params

  Exec{path => $ldap::client::params::path }

  $ldap_server = $ldap::client::params::host
  $ldap_dn     = $ldap::client::params::dn
  $key         = $ldap::client::params::key
 

  $cmd = "authconfig --enableldap --enableldapauth --ldapserver=$ldap_server --ldapbasedn=$ldapdn --enableldaptls --ldaploadcacert=$key --update"

  exec {'ldap-client-config':
	command => $cmd
  }

}

