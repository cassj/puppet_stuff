class python::params{

 $pkg_name = 'python'
 
 $pip_pkg_name = 'python-pip'
 $pip_binary = '/usr/bin/pip-python'

 case $operatingsystem {
    /(Ubuntu|Debian)/:{
      $dev_pkg_name = 'python-dev'
    }
    /(RedHat|CentOS|Fedora|Scientific)/:{
      $dev_pkg_name = 'python-devel'
    }
  }

}
