class nginx::params {
  case $operatingsystem {
    /(Ubuntu|Debian)/:{
      $pkg_name = 'nginx'
      $cfg_file = '/etc/nginx/nginx.conf'
      $service  = 'nginx'
    }
    /(RedHat|CentOS|Fedora|Scientific)/:{
      $pkg_name = 'nginx'
      $cfg_file = '/etc/nginx/nginx.conf'
      $service  = 'nginx'
    }
  }
}


