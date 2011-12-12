class ftp::server::config {

  include ftp::server::params

  Exec{path=>$ftp::server::params::path}

  file {$ftp::server::params::cfg_file:
    ensure  => present,
    source  => 'puppet:///modules/ftp/vsftpd.conf',
    owner   => $ftp::server::params::user,
    group   => $ftp::server::params::group,
    require => Class['ftp::server::install'],
    notify  => Class['ftp::server::service']
  }

  if $ftp::server::params::iptables { 
    exec {'ftp-server-iptables-conntrack':
      unless => 'grep nf_conntract_ftp $ftp::server::params::iptables_cfg',
      command => 'sed s///'

    } 
  } 

}
