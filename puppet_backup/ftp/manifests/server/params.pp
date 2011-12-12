class ftp::server::params ($iptables=true) {

  # runnign as root?
  $path = '/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin'
  $pkg_name = 'vsftpd'
  $service  = 'vsftpd'
  $cfg_file = '/etc/vsftpd/vsftpd.conf'
  $user = 'root'
  $group = 'root'
  $pubdir = '/var/ftp/pub'
  $iptables_cfg = '/etc/sysconfig/iptables-config'
}
