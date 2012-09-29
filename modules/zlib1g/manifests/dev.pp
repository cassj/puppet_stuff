class zlib1g::dev {
  require 'zlib1g'
  package {$zlib1g::params::dev_pkg_name:
    ensure => installed,
  }
}
