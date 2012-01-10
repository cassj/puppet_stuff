class glassfish::params{

  $path = '/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin'
  $java_class = 'sunjava'
  $install_dir = '/usr/local' 
  $download_site = 'http://download.java.net/javaee5/v2.1.1_branch/promoted/Linux'
  $download_file = 'glassfish-installer-v2.1.1-b31g-linux.jar'
  $as_install = "$install_dir/glassfish"


  #$download_file = 'glassfish-3.1.1.zip'
  #$download_site = 'http://download.java.net/glassfish/3.1.1/release' 
  #$as_install = "$install_dir/glassfish/glassfish3/glassfish"
  #$as_install_parent = "$install_dir/glassfish/glassfish3"
  #$domain_root_dir = "$as_install/domains"

}
