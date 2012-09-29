class libc6::dev {
  require 'libc6'
  package {$libc6::params::dev_pkg_name:
    ensure => installed,
  }
}
