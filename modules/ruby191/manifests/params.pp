class ruby191::params {

  case $operatingsystem {
    /(Ubuntu|Debian)/:{
      $pkg_name     = 'ruby1.9.1'
      $dev_pkg_name = 'ruby1.9.1-dev' # 1.9+ includes rubygems
      $gems_bin     = '/var/lib/gems/1.9.1/bin'
      $inotify_pkg_name = 'librb-inotify-ruby1.9.1'
    }
    /(RedHat|CentOS|Fedora|Scientific)/:{
      fail 'package not available in RHEL flavours yet'
    }
  }


}
