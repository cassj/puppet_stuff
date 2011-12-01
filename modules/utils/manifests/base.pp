class utils::base {

  $path = '/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin'

  Exec { path => $path }

  Package {ensure => installed}

}
