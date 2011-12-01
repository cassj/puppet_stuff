class apache::config{

  file{$apache::params::cfg_file:
    ensure  => present,
    source  => 'puppet:///modules/apache/httpd.conf',
    owner   => $apache::params::user,
    group   => $apache::params::user,
    require => Class['apache::install'],
    notify  => Class['apache::service'],
  }


}
~         
