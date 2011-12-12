# All parameters for all obiba components collected into
# one place for ease of editing

class obiba::params ($user='obiba', $home='/opt/obiba'){
  $path = '/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin'

  $obiba_user = 'obiba'
  $obiba_home = '/opt/obiba'

  #Parameters for opal
  $opal_dlfile    = 'opal-server-1.5.0-dist.zip'
  $opal_site      = 'http://maven.obiba.org/maven2/org/obiba/opal/opal-server/1.5.0'
  $opal_serverdir = 'opal-server-1.5.0'

  #Parameters for mica
  $mica_dlfile    =  'mica-dist-1.0-b13850.zip'
  $mica_site      =  'http://download.obiba.org/mica/stable'
  $micadir        =  "$obiba_home/mica/mica-1.0"

}
