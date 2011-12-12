# This is the main obiba class and the one which your nodes should
# declare. By default, it will manage all of the obiba components,
# however you can set individual components to false in your declaration
# if you don't want to use them.
class obiba (
    $fqdn, 
    $user            = 'obiba', 
    $group           = 'obiba', 
    $home            = '/opt/obiba', 
    $onyx            = true,
    $opal            = true,
    $genobyte        = true,
    $mica            = true,
    $ark             = true,
    $mysql_root_pass = "",
    $admin_user      = 'admin',
    $admin_pass      = 'password',
    $opal_db_user    = "opal",
    $opal_keydb_user = "opalkey",
    $opal_db_pass    = "opal",
    $opal_keydb_pass = "opal",
    $opal_db         = "opal",
    $opal_keydb      = "key",
    $mica_db         = 'mica',
    $mica_db_user    = 'mica',
    $mica_db_pass    = 'mica',
    $mica_port       = 80
  ){

  # For required classes that aren't under our direct control,
  # just declare the requirement and allow the node to handle it.
  Class['mysql']->Class['obiba']
  Class['tomcat']->Class['obiba']

  # This class creates shared resources 
  class {'obiba::common': 
    user  => $user,
    home  => $home,
    group => $group,
  }

  if $onyx {
    class {'obiba::onyx':}
  }
  if $opal {
    class {'obiba::opal':
      obiba_user      => $user,
      obiba_group     => $group,
      obiba_home      => $home,
      db_user         => $opal_db_user,
      keydb_user      => $opal_keydb_user,
      db_pass         => $opal_db_pass,
      keydb_pass      => $opal_keydb_pass,
      db              => $opal_db, 
      keydb           => $opal_keydb,
      admin_user      => $admin_user,
      admin_pass      => $admin_pass,
      mysql_root_pass => $mysql_root_pass,
    }
  }
  if $genobyte {
    class {'obiba::genobyte':
      obiba_user      => $user,
      obiba_group     => $group,
      obiba_home      => $home
    }
  }
  if $mica {
    class {'obiba::mica':
      obiba_fqdn      => $fqdn,
      obiba_user      => $user,
      obiba_group     => $group,
      obiba_home      => $home,
      mysql_root_pass => $mysql_root_pass,
      db              => $mica_db,
      db_user         => $mica_db_user,
      db_pass         => $mica_db_pass,
      port            => $mica_port,
    }
  }
  if $ark {
    class {'obiba::ark':}
  }
   

  #apache::vhost{ $url:
  #  port          => $port,
  #  docroot       => $docroot,
  #  ssl           => $ssl,
  #  priority      => $priority,
  #}


}

