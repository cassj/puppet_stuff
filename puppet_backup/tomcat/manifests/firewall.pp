class tomcat::firewall{

  include tomcat::params
  
  Exec{ path => $tomcat::params::path }

  $cmd = "-I INPUT -p tcp -m tcp --dport $tomcat::params::port -j ACCEPT"
  exec{"dataverse-port-$tomcat::params::port":
    unless => "grep '$cmd' /etc/sysconfig/iptables",
    command => "iptables $cmd; iptables-save > /etc/sysconfig/iptables",
  }

}
