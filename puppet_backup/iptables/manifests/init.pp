class iptables{

 include iptables::openport, iptables::closeport

}

define iptables::openport($number, $t='tcp', ){

  Exec{

  }
}

define iptables::closeport($number)

#define iptables::natredirect(){}
