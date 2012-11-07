class biomart::params {
  case $operatingsystem {
    Solaris : {
      $pkg_name = 'openssh'
      $cfg_file = '/etc/ssh/sshd_config'
      $service  = 'sshd'
    }
    /(Ubuntu|Debian)/:{
      $pkg_name = 'openssh-server'
      $cfg_file = '/etc/ssh/sshd_config'
      $service  = 'ssh'
    }
    /(RedHat|CentOS|Fedora|Scientific)/:{
      $pkg_name = 'openssh-server'
      $cfg_file = '/etc/ssh/sshd_config'
      $service  = 'sshd'
    }
  }
}
