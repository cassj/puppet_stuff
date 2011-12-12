class bind::config{
  file {$bind::params::cfg_file:
    ensure  => present,
    owner   => 'root',
    group   => 'root',
    mode    => 0600,
    source  => 'puppet:///modules/bind/named.conf',
    require => Class['bind::install'],
    notify  => Class['bind::service'],
  }
}
