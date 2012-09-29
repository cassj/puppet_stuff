class buildtools::params {
  case $operatingsystem {
    /(Ubuntu|Debian)/:{
      $pkg_name = 'build-essential'
    }
    /(RedHat|CentOS|Fedora|Scientific)/:{
      $pkg_name = [ 'autoconf', 'automake', 'binutils', 'gcc', 'gcc-c++', 'gettext', 'libtool', 'make', 'patch', 'pkgconfig', 'redhat-rpm-config', 'rpm-build', 'byacc', 'cscope', 'ctags', 'diffstat', 'doxygen','elfutils', 'gcc-gfortran']
    }
  }
}
