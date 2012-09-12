class selinux::params{

 case $operatingsystem {
    /(Ubuntu|Debian)/:{
      #$pkgs = ['libselinux1', 'selinux-policy-default', 'selinux-utils', 'policycoreutils']
      # debian support for selinux not as developed as RHEL. Think I'll just leave it out for now
      $pkgs=[]
    }
    /(RedHat|CentOS|Fedora|Scientific)/:{
      $pkgs = ['libselinux', 'selinux-policy', 'libsemanage', 'policycoreutils-python']
    }
  }

}
