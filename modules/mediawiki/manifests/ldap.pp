# Set up mediawiki to validate from an LDAP server
# Note that the admin user must exist in the LDAP dir.
define mediawiki::ldap (
  $fqdn,
  $docroot,
  $admin_user,
  $admin_pass,
  $ldap_server,
  $ldap_domain
) {

  include mediawiki::params
  include apache::params
  include php::ldap 

  # generated tarball, can't just download. So upload from here.
  file{"/tmp/$fqdn.ldap.tgz":
    ensure   => file,
    source   => 'puppet:///modules/mediawiki/LdapAuthentication-MW1.18-r90286.tar.gz',
  }

  # unpack it
  utils::tar::untar_file{"/tmp/$fqdn.ldap.tgz":
    cwd         => "$docroot/wiki/extensions",
    user        => $apache::params::user,
    group       => $apache::params::group,
    gzip_filter => true,
    creates     => "$docroot/wiki/extensions/LdapAuthentication",
    require     => File["/tmp/$fqdn.ldap.tgz"]
  }

  file{"$docroot/wiki/ldap_settings.php":
    ensure    => present,
    content   => template('mediawiki/ldap_settings.php.erb'),
    owner     => $apache::params::user,
    group     => $apache::params::user,
    require   => Utils::Tar::Untar_file["$fqdn-$mediawiki::params::download_file"],
    subscribe => Utils::Tar::Untar_file["$fqdn-$mediawiki::params::download_file"]
  }

  exec{'mediawiki-ldap-enable':
    command => "/bin/cat $docroot/wiki/ldap_settings.php >> $docroot/wiki/LocalSettings.php",
    unless  => "/bin/grep 'LdapAuthenticationPlugin' $docroot/wiki/LocalSettings.php",
    onlyif  => "/usr/bin/test -e $docroot/wiki/LocalSettings.php",
    require => File["$docroot/wiki/ldap_settings.php"]
  }



  #See http://ryandlane.com/blog/2009/03/23/using-the-ldap-authentication-plugin-for-mediawiki-the-basics-part-1/

}
