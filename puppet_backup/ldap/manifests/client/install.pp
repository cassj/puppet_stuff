class ldap::client::install {
 
   include ldap::client::params

   package {$ldap::client::params::pkg_name:
     ensure => installed  
   }
}
