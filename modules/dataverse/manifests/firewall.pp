# this isn't working. have done it manually for now.
# I've put a working iptables file in files
class dataverse::firewall{

  include dataverse::params

  Exec{path => $dataverse::params::path}

#  # open port 80 for http
#  $cmd80 = '-A INPUT -m state --state NEW -m tcp -p tcp --dport 80 -j ACCEPT'
#  exec{'dataverse-port-80':
#    unless => "grep $cmd80 /etc/sysconfig/iptables",
#    command => "iptables $cmd80; iptables-save > /etc/sysconfig/iptables",
#  }
#
#  # and port 443 for glassfish remote admin
#  $cmd443 = '-A INPUT -m state --state NEW -m tcp -p tcp --dport 443 -j ACCEPT'
#  exec{'dataverse-port-443':
#    unless => "grep $cmd443 /etc/sysconfig/iptables",
#    command => "iptables $cmd; iptables-save > /etc/sysconfig/iptables",
#  }

}
