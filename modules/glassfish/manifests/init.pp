class glassfish ($java_class="sunjava", $install_dir="/usr/local/glassfish", $port='8080', $admin_port='4848', $admin_user='admin', $admin_password=''){

  class {'glassfish::params':
    java_class     => $java_class,
    install_dir    => $install_dir,
    port           => $port,
    admin_port     => $admin_port,
    admin_user     => $admin_user,
    admin_password => $admin_password
  }
  include $glassfish::params::java_class, utils::zip, glassfish::install
 
}
