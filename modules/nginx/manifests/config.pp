class nginx::config {
  file {$nginx::params::cfg_file:
    ensure  => present,
    owner   => 'root',
    group   => 'root',
    mode    => 0600,
    source  => 'puppet:///modules/nginx/nginx.conf',
    require => Class['nginx::install'],
    notify  => Class['nginx::service'],
  }
}

