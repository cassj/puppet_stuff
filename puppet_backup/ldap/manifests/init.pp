class ldap::client ($host_ip=$::ipaddress, $dn, $key){

  # ignoring kerberos for now.
  class {'ldap::client::params':
    host_ip => $host_ip,
    dn      => $dn,
    key     => $key
  }
  include ldap::client::install, ldap::client::config
}

class ldap::server ($password, $dn) {

  class {'ldap::server::params': 
    password => $password,
    dn       => $dn
  }

  include ldap::server::install, ldap::server::config, ldap::server::service  

}

