class vsftpd::config ($config_file){
  file {$vsftpd::params::cfg_file:
    ensure  => present,
    owner   => 'root',
    group   => 'root',
    mode    => 0600,
    source  => $config_file,
    require => Class['vsftpd::install'],
    notify  => Class['vsftpd::service'],
  }
}

